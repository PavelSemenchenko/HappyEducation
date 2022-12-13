//
//  EmailTextField.swift
//  HappyEducation
//
//  Created by MakBook on 13.12.2022.
//

import Foundation
import UIKit

class EmailTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.blue.cgColor
    }
    func validateEmailTextfield(errorLabel: UILabel) -> String? {
        let optionalEmail = text
        guard let email = optionalEmail, email.contains("@") else {
            layer.borderColor = UIColor.red.cgColor
            errorLabel.text = "Email is invalid"
            errorLabel.isHidden = false
            return nil
        }
        layer.borderColor = UIColor.green.cgColor
        errorLabel.isHidden = true
        return email
    }
}
