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
// import AlamofireImage
// import Alamofire

struct Teacher: Codable {
    @DocumentID var id: String?
    let name: String
    let subject: String
    let image: String
    let authorId: String
}

protocol TeachersRepository {
    func getAll(complletion: @escaping ([Teacher]) -> Void)
    func createTeacher(name: String, subject: String, image: String) -> Teacher
    func update(value: Teacher)
    func delete(teacherId: String)
}

class FirebaseTeachersRepository: TeachersRepository {
    func delete(teacherId: String) {
        teachersCollection.document(teacherId).delete()
    }
    
    func update(value: Teacher) {
        guard let documentId = value.id else {
            return
        }
        try? teachersCollection.document(documentId).setData(from: value)
    }
    
     
    func createTeacher(name: String, subject: String, image: String) -> Teacher {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            fatalError("Not authenticated user")
        }
        var teacher = Teacher(name: name, subject: subject, image: image, authorId: currentUserId)
        guard let reference = try? teachersCollection.addDocument(from: teacher) else {
            fatalError("Failed to create new teacher")
        }
        teacher.id = reference.documentID
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
