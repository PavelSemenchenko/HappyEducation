//
//  TeachersRepository.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 29.12.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import UIKit

struct Teacher: Codable {
    @DocumentID var id: String?
    let name: String
    let subject: String
    fileprivate(set) var image: String = ""
    let authorId: String?
}

protocol TeachersRepository {
    func getAll(complletion: @escaping ([Teacher]) -> Void)
    func createTeacher(name: String, subject: String, image: URL) -> Teacher
    func update(value: Teacher)
    func delete(teacherId: String)
}

class FirebaseTeachersRepository: TeachersRepository {
    
    let fileStorageService: FileStorageService = FirebaseFileStorageService()
    
    func delete(teacherId: String) {
        teachersCollection.document(teacherId).delete()
    }
    
    func update(value: Teacher) {
        guard let documentId = value.id else {
            return
        }
        try? teachersCollection.document(documentId).setData(from: value)
    }
    
    func createTeacher(name: String, subject: String, image: URL) -> Teacher {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            fatalError("Not authenticated user")
        }
        var teacher = Teacher(name: name, subject: subject, authorId: currentUserId)
        guard let reference = try? teachersCollection.addDocument(from: teacher) else {
            fatalError("Failed to create new teacher")
        }
        let teacherId = reference.documentID
        teacher.id = teacherId
        teacher.image = "https://firebasestorage.googleapis.com/v0/b/happyeducation-bcb82.appspot.com/o/teachers%2F\(teacherId).jpg?alt=media"
                       
        try? teachersCollection.document(teacherId).setData(from: teacher)
        
        fileStorageService.uploadTeacherPhoto(teacherId: teacherId, photo: image) { _ in }
        return teacher
    }
        
    lazy var teachersCollection: CollectionReference = {
        return Firestore.firestore().collection("teachers")
    }()
    
    func getAll(complletion: @escaping ([Teacher]) -> Void) {
        teachersCollection.getDocuments { snapshot, _ in
            guard let docs = snapshot?.documents else {
                complletion([])
                return
            }
            var teachers: [Teacher] = []
            for doc in docs {
                guard let teacher = try? doc.data(as: Teacher.self) else {
                    continue
                }
                teachers.append(teacher)
            }
            complletion(teachers)
        }
    }
}
