//
//  GradeSelectVC.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 15.12.2022.
//

import Foundation
import UIKit

enum Grade {
    case none
    case from1to5
    case from6to9
    case from10to11
    case from12to13
}

class GradeSelectVC: UIViewController {
    
    @IBOutlet weak var grade1to5Button: UIButton!
    @IBOutlet weak var grade6to9Button: UIButton!
    @IBOutlet weak var grade10to11Button: UIButton!
    @IBOutlet weak var grade12to13Button: UIButton!
    
    var grade: Grade = .none
    
    func validateGrades() {
        if grade == .from1to5 {
            grade1to5Button.backgroundColor = .systemIndigo
            grade1to5Button.tintColor = .white
            grade6to9Button.backgroundColor = .systemGray6
            grade10to11Button.backgroundColor = .systemGray6
            grade12to13Button.backgroundColor = .systemGray6
        } else if grade == .from6to9 {
            grade1to5Button.backgroundColor = .systemGray6
            grade6to9Button.backgroundColor = .systemIndigo
            grade6to9Button.tintColor = .white
            grade10to11Button.backgroundColor = .systemGray6
            grade12to13Button.backgroundColor = .systemGray6
        } else if grade == .from10to11 {
            grade1to5Button.backgroundColor = .systemGray6
            grade6to9Button.backgroundColor = .systemGray6
            grade10to11Button.backgroundColor = .systemIndigo
            grade10to11Button.tintColor = .white
            grade12to13Button.backgroundColor = .systemGray6
        } else if grade == .from12to13 {
            grade1to5Button.backgroundColor = .systemGray6
            grade6to9Button.backgroundColor = .systemGray6
            grade10to11Button.backgroundColor = .systemGray6
            grade12to13Button.backgroundColor = .systemIndigo
            grade12to13Button.tintColor = .white
        } else if grade == .none {
            grade1to5Button.backgroundColor = .systemGray6
            grade1to5Button.tintColor = .darkGray
            grade6to9Button.backgroundColor = .systemGray6
            grade6to9Button.tintColor = .darkGray
            grade10to11Button.backgroundColor = .systemGray6
            grade10to11Button.tintColor = .darkGray
            grade12to13Button.backgroundColor = .systemGray6
            grade12to13Button.tintColor = .darkGray
        }
    }
    
    @IBAction func grade1to5Clicked(_ sender: Any) {
        if grade == .from1to5 {
            grade = .none
        } else {
            grade = .from1to5
        }
        validateGrades()
    }
    
    @IBAction func grade6to9Clicked(_ sender: Any) {
        if grade == .from6to9 {
            grade = .none
        } else {
            grade = .from6to9
        }
        validateGrades()
    }
    
    @IBAction func grade10to11Clicked(_ sender: Any) {
        if grade == .from10to11 {
            grade = .none
        } else {
            grade = .from10to11
        }
        validateGrades()
    }
    
    @IBAction func grade12to13Clicked(_ sender: Any) {
        if grade == .from12to13 {
            grade = .none
        } else {
            grade = .from12to13
        }
        validateGrades()
    }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
    }
    
    @IBAction func skipButtonClicked(_ sender: Any) {
    }
}


/*
 если нажат уровень - borderColor.blue.cgColor
 и все уровни в дефолт
 
 ?? выбор только одного уровня ( смена со сбросом)
 
 если выбран уровень is hiden = false
 
 
 
 */
