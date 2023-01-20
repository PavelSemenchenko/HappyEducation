//
//  InstitutionsRepository.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 29.12.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Institution: Codable {
    @DocumentID var id: String?
    let name: String
    fileprivate(set) var image: String = ""
    let description: String
    let rating: Double
    let voted: Int
    let subject: String
    let authorId: String?
}
protocol InstitutionRepository {
    func getAll(completion: @escaping ([Institution]) -> Void)
    func createInstitution(name: String, image: URL, description: String, rating: Double, voted: Int, subject: String) -> Institution
}
class FirebaseInstitutionRepository: InstitutionRepository {
    
    let fileStorageService: FileStorageService = FirebaseFileStorageService()
    
    func delete(institutionId: String) {
        institutionsCollection.document(institutionId).delete()
    }
    
    func update(value: Institution) {
        guard let documentId = value.id else {
            return
        }
        try? institutionsCollection.document(documentId).setData(from: value)
    }
    
    func createInstitution(name: String, image: URL, description: String, rating: Double, voted: Int, subject: String) -> Institution {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            fatalError("Need authorithation")
        }
        var institution = Institution(name: name, description: description, rating: rating, voted: voted, subject: subject, authorId: currentUserId)
        guard let reference = try? institutionsCollection.addDocument(from: institution) else {
            fatalError("Failed to create institution")
        }
        let institutionId = reference.documentID
        institution.id = institutionId
        institution.image = "https://firebasestorage.googleapis.com/v0/b/happyeducation-bcb82.appspot.com/o/institutions%2F\(institutionId).jpg?alt=media"
        
        try? institutionsCollection.document(institutionId).setData(from: institution)
        
        fileStorageService.uploadInstitutionPhoto(institutionId: institutionId, photo: image) { _ in }
        return institution
    }
    
    lazy var institutionsCollection: CollectionReference = {
        return Firestore.firestore().collection("institutions")
    }()
    
    func getAll(completion: @escaping ([Institution]) -> Void) {
        institutionsCollection.getDocuments { snapshot, _ in
            guard let docs = snapshot?.documents else {
                completion([])
                return
            }
            var institutions: [Institution] = []
            for doc in docs {
                guard let institution = try? doc.data(as: Institution.self) else {
                    continue
                }
                institutions.append(institution)
            }
            completion(institutions)
        }
    }
}
