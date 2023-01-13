//
//  Authetitication.swift
//  HappyEducation
//
//  Created by MakBook on 13.12.2022.
//

import Foundation
import FirebaseAuth

protocol AuthentiticationService {
    func signIn(email: String, password: String, completion: @escaping (String?) -> Void)
    func signUp(name: String, email: String, password: String, completion: @escaping (String?) -> Void)
    func forgotPassword(email: String, completion: @escaping (String?) -> Void)
    func isAuthenticated() -> Bool
    func userDisplayName() -> String?
    func logOut()
}

class FirebaseAuthentiticationService: AuthentiticationService {
    
    func userDisplayName() -> String? {
        return Auth.auth().currentUser?.displayName
    }
      
    func signIn(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if result?.user != nil {
                completion(nil)
            } else {
                let message = error?.localizedDescription
                completion(message)
            }
        }
    }
    func signUp(name: String, email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let user = result?.user {
                let request = user.createProfileChangeRequest()
                request.displayName = name
                request.commitChanges()
                completion(nil)
            } else {
                let message = error?.localizedDescription
                completion(message)
            }
        }
    }
    func forgotPassword(email: String, completion: @escaping (String?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error?.localizedDescription)
        }
    }
    func logOut() {
        try? Auth.auth().signOut()
    }
    
    func isAuthenticated() -> Bool {
        let hasUser = Auth.auth().currentUser != nil
        return hasUser 
    }
}
