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
    let name: String
    let image: String
    let description: String
    let rating: Double
    let voted: Int
    let subject: String
}
