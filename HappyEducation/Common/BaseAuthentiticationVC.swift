//
//  BaseAuthentiticationVC.swift
//  HappyEducation
//
//  Created by MakBook on 13.12.2022.
//

import Foundation
import UIKit

protocol BaseAuthentiticationVC: UIViewController {
    var emailField: EmailTextField! { get }
    var errorEmailLabel: UILabel! { get }
    var passwordField : PasswordTextField { get }
    var errorPasswordLabel : UILabel! { get }
}

extension BaseAuthentiticationVC {
    func validateFields() {
        let optionalEmail = emailField.text
        guard let email = optionalEmail, email.contains("@") else {
            emailField.layer.borderColor = UIColor.red.cgColor
            errorEmailLabel.text = "Email is invalid format"
            errorEmailLabel.isHidden = false
            return
        }
        emailField.layer?.borderColor = UIColor.green.cgColor
        errorEmailLabel.isHidden = true
        let optionalPassword = passwordField.text
        guard let password = optionalPassword, password.count >=6 else {
            passwordField.layer?.borderColor = UIColor.red.cgColor
            errorPasswordLabel.text = "Password must be 6 or bigger"
            errorPasswordLabel.isHidden = false
            return
        }
        passwordField.layer.borderColor = UIColor.green.CGColor
        errorPasswordLabel.isHidden = true
    }
}
