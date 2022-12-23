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
    
    
    var arrayProvince: [String] = []
    func validateProvince() {
        if arrayProvince.contains(<#T##other: Collection##Collection#>) {
            nextButton.isEnabled = true
        } else if arrayProvince.contains(<#T##other: Collection##Collection#>) {
            nextButton.isEnabled = true
        }
    }
    
    @IBAction func firstButtonClicked(_ sender: Any) {
        if arrayProvince.contains(<#T##Self.Element#>) {
            arrayProvince.remove(at: <#T##Int#>)
        } else {
            arrayProvince.append(<#T##newElement: String##String#>)
        }
    }
    @IBAction func secondButtonClicked(_ sender: Any) {
    }
    @IBAction func thirdButtonClicked(_ sender: Any) {
    }
    @IBAction func forthButtonClicked(_ sender: Any) {
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
    }
    @IBAction func skipButtonClicked(_ sender: Any) {
    }
    
}
