//
//  SignUpVC.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 13.12.2022.
//

import Foundation
import UIKit

class SignUpVC: UIViewController, BaseAuthentiticationVC {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: EmailTextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    
    let authenticationService: AuthentiticationService = FirebaseAuthentiticationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signUpButtonclicked(_ sender: Any) {
        validateFields()
        
        let optionalEmail = emailTextField.text
        guard let email = optionalEmail, email.contains("@") else {
            emailTextField.layer.borderColor = UIColor.red.cgColor
            errorEmailLabel.text = "Enter correcnt email"
            errorEmailLabel.isHidden = false
            return
        }
        emailTextField.layer.borderColor = UIColor.green.cgColor
        errorEmailLabel.isHidden = true
        
        let optionalPassword = passwordTextField.text
        guard let password = optionalPassword, password.count >= 6 else {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            errorPasswordLabel.text = "Enter password lager then 6"
            errorPasswordLabel.isHidden = false
            return
        }
        
        passwordTextField.layer.borderColor = UIColor.green.cgColor
        errorPasswordLabel.isHidden = true
        
        authenticationService.signUp(email: email, password: password) { errorMessage in
            if let message = errorMessage {
                let alert = UIAlertController(title: "Happe Education",
                                              message: message,
                                              preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Fine", style: UIAlertAction.Style.default))
                self.present(alert, animated: true)
            } else {
                guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else {
                    return
                }
                self.navigationController?.pushViewController(homeVC, animated: true)
            }
        }
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        guard let login = self.storyboard?.instantiateViewController(withIdentifier: "SignIn") as? SignInVC else { return
            
        }
        self.navigationController?.pushViewController(login, animated: true)
    }
    
}