//
//  BaseAuthentiticationVC.swift
//  HappyEducation
//
//  Created by MakBook on 13.12.2022.
//

import Foundation
import UIKit

protocol BaseAuthentiticationVC: UIViewController {
    var emailTextField: EmailTextField! { get }
    var errorEmailLabel: UILabel! { get }
    var passwordTextField : PasswordTextField! { get }
    var errorPasswordLabel : UILabel! { get }
}

extension BaseAuthentiticationVC {
    func validateFields() {
        let optionalEmail = emailTextField.text
        guard let email = optionalEmail, email.contains("@") else {
            emailTextField.layer.borderColor = UIColor.red.cgColor
            errorEmailLabel.text = "Email is invalid format"
            errorEmailLabel.isHidden = false
            return
        }
        emailTextField.layer.borderColor = UIColor.green.cgColor
        errorEmailLabel.isHidden = true
        let optionalPassword = passwordTextField.text
        guard let password = optionalPassword, password.count >= 6 else {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            errorPasswordLabel.text = "Password must be 6 or bigger"
            errorPasswordLabel.isHidden = false
            return
        }
        passwordTextField.layer.borderColor = UIColor.green.cgColor
        errorPasswordLabel.isHidden = true
    }
}
