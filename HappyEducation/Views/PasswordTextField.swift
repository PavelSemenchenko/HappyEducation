//
//  PasswordTextField.swift
//  HappyEducation
//
//  Created by MakBook on 13.12.2022.
//

import Foundation
import UIKit

class PasswordTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.blue.cgColor
    }
    func validatePasswordTextField(errorLabel: UILabel) -> String? {
        let optionalPassword = text
        guard let password = optionalPassword, password.count >= 6 else {
            layer.borderColor = UIColor.red.cgColor
            errorLabel.text = "Password wrong, should be longer 6"
            errorLabel.isHidden = false
            return nil
        }
        layer.borderColor = UIColor.green.cgColor
        errorLabel.isHidden = true
        return password
    }
}
