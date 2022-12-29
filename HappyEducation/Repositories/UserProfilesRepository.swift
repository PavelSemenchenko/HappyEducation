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
    @DocumentID var id: String?
    let name: String
    let email: String
    let password: String
}

protocol UserProfilesRepository {
    func getAll()
    func getOne(userId: String, completion: @escaping (UserProfile?) -> Void)
    func create(profile: UserProfile)
    func delete()
}

class FirebaseUsesrProfilesRepository: UserProfilesRepository {
    func getAll() {
        
    }
    
    func getOne(userId: String, completion: @escaping (UserProfile?) -> Void) {
        Firestore.firestore().collection("profiles")
            .document(userId)
            .getDocument(as: UserProfile.self) { snapshot in
            switch(snapshot) {
            case .success(let profile):
                completion(profile)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func create(profile: UserProfile) {
        var userProfile = profile
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            fatalError("Only after authentication")
        }
        userProfile.id = currentUserId
        try? Firestore.firestore()
            .collection("profiles")
            .document(currentUserId)
            .setData(from: userProfile)
    }
    
    func delete() {
        
    }
    
    func update() {
        
    }
    
    
}
