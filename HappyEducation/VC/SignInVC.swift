//
//  SignInVC.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 13.12.2022.
//

import Foundation
import UIKit

class SignInVC: UIViewController, BaseAuthentiticationVC, UITextFieldDelegate {
        
    @IBOutlet weak var emailTextField: EmailTextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    @IBOutlet weak var errorEmailLabel: UILabel!
    
    let authenticationService: AuthentiticationService = FirebaseAuthentiticationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func signIn() {
        guard let email = emailTextField.validateEmailTextfield(errorLabel: errorEmailLabel) else {
            return
        }
        guard let password = passwordTextField.validatePasswordTextField(errorLabel: errorPasswordLabel) else {
            return
        }
        authenticationService.signIn(email: email, password: password) { errorMessage in
            if let message = errorMessage {
                let alert = UIAlertController(title: "Happy Education", message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default))
                self.present(alert, animated: true)
            } else {
                guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else {
                    return
                }
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        signIn()
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
    }
}
