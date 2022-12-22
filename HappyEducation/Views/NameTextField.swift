//
//  NameTextField.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 21.12.2022.
//

import Foundation
import UIKit

class NameTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowOpacity = 1
        layer.shadowRadius = 10.0
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.gray.cgColor
    }
}
