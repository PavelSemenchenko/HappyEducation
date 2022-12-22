//
//  SignUpVC.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 13.12.2022.
//

import Foundation
import UIKit

class SignUpVC: UIViewController, BaseAuthentiticationVC, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: NameTextField!
    @IBOutlet weak var emailTextField: EmailTextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    
    let authenticationService: AuthentiticationService = FirebaseAuthentiticationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // emailTextField.delegate = self
        // passwordTextField.delegate = self
        
        // keyboard Hiding
        registerForKeyboardNotifications()
    }
    deinit {
        removeKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0.0, y: kbFrameSize.height/1.8)
    }
    @objc func kbWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
    
    @IBAction func signUpButtonclicked(_ sender: Any) {
        validateFields()
        
        let optionalEmail = emailTextField.text
        guard let email = optionalEmail, email.contains("@") else {
            emailTextField.layer.borderColor = UIColor.red.cgColor
            errorEmailLabel.text = "Enter correct email"
            errorEmailLabel.isHidden = false
            return
        }
        emailTextField.layer.borderColor = UIColor.green.cgColor
        errorEmailLabel.isHidden = true
        
        let optionalPassword = passwordTextField.text
        guard let password = optionalPassword, password.count >= 6 else {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            errorPasswordLabel.text = "Enter password > 5"
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
                guard let GradeSelect = self.storyboard?.instantiateViewController(withIdentifier: "GradeSelectVC") as? GradeSelectVC else {
                    return
                }
                self.navigationController?.pushViewController(GradeSelect, animated: true)
            }
        }
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        guard let login = self.storyboard?.instantiateViewController(withIdentifier: "SignIn") as? SignInVC else { return
            
        }
        self.navigationController?.pushViewController(login, animated: true)
    }
    
}
