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
    func createInstitution(name: String, image: URL, description: String, subject: String) -> Institution
}
class FirebaseInstitutionRepository: InstitutionRepository {
    
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
