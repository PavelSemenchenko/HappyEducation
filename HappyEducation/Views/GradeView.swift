//
//  GradeView.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 21.12.2022.
//

import Foundation
import UIKit

@IBDesignable
class GradeView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artsButton: UIButton!
    @IBOutlet weak var mathButton: UIButton!
    
    var currentgrade: Grade = .none
    var originalGrade: Grade!
    
    @IBInspectable
    var gradeTitle: String? {
        get {
            return titleLabel.text
        } set {
            titleLabel.text = newValue
        }
    }
    
    @IBAction func gradeViewClicked(_ sender: Any) {
        if currentgrade == originalGrade {
            currentgrade = .none
            frame.height = frame.height - 100
        } else {
            currentgrade = originalGrade
            frame.height = frame.height + 100
        }
         
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        if let defaultBundleView = UINib(nibName: "GradeView",
                                         bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil).first as? UIView {
            addSubview(defaultBundleView)
        } else {
            fatalError("Cannot load view from bundle")
        }
    }
}
