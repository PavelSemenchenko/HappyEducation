//
//  ProvinceVC.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 16.12.2022.
//

import Foundation
import UIKit

enum Province {
    case none
    case central
    case eastern
    case nothCentral
    case nothern
    case nothWestern
    case sabaragamuwa
    case southern
    case uva
    case western
}

class ProvinceVC: UIViewController {
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var forthButton: UIButton!
    @IBOutlet weak var fifthButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    var province: Province = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if province != .none {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    
    let arrayProvince: [String] = ["Central", "Eastern", "Noth Central", "Nothern"]
    var arrayProvinceSum: [String] = []
    
    func validateProvince() {
        if arrayProvinceSum.count <= 3 {
            nextButton.isEnabled = true
        } else if arrayProvince.count < 1 || arrayProvinceSum.count > 3 {
            nextButton.isEnabled = false
        }
    }
    
    @IBAction func firstButtonClicked(_ sender: Any) {
        if arrayProvinceSum.contains("Central") {
            arrayProvinceSum.remove(at: 0)
        } else {
            arrayProvinceSum.insert("Central", at: 0)
            validateProvince()
        }
    }
    @IBAction func secondButtonClicked(_ sender: Any) {
        if arrayProvinceSum.contains("Eastern") {
            arrayProvinceSum.remove(at: 1)
        } else {
            arrayProvinceSum.insert("Eastern", at: 1)
            validateProvince()
        }
    }
    @IBAction func thirdButtonClicked(_ sender: Any) {
        if arrayProvinceSum.contains("Noth Central") {
            arrayProvinceSum.remove(at: 2)
        } else {
            arrayProvinceSum.insert("Noth Central", at: 2)
            validateProvince()
        }
    }
    @IBAction func forthButtonClicked(_ sender: Any) {
        if arrayProvinceSum.contains("Nothern") {
            arrayProvinceSum.remove(at: 3)
        } else {
            arrayProvinceSum.insert("Nothern", at: 3)
        }
    }
    @IBAction func fifthButtonClicked(_ sender: Any) {
    }
    @IBAction func sixButtonClicked(_ sender: Any) {
    }
    @IBAction func sevenButtonClicked(_ sender: Any) {
    }
    @IBAction func eightButtonClicked(_ sender: Any) {
    }
    @IBAction func nineButtonClicked(_ sender: Any) {
    }
    
    
    
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else {
            return
        }
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func skipButtonClicked(_ sender: Any) {
    }
    
}
