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
    func signUp(email: String, password: String, completion: @escaping (String?) -> Void)
    func forgotPassword(email: String, completion: @escaping (String?) -> Void)
    func isAuthenticated() -> Bool
    func logOut()
}

class FirebaseAuthentiticationService: AuthentiticationService {
      
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
    func signUp(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if result?.user != nil {
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
