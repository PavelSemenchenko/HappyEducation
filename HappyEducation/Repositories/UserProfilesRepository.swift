//
//  UserProfilesRepository.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 29.12.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserProfile: Codable {
    let name: String
    let email: String
    let password: String
}

