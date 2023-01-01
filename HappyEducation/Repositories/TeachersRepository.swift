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
import AlamofireImage
import Alamofire

struct Teacher: Codable {
    let name: String
    let subject: String
    let image: String
}

protocol TeachersRepository {
    func getAll(complletion: @escaping ([Teacher]) -> Void)
}
class FirebaseTeachersRepository: TeachersRepository {
        
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
