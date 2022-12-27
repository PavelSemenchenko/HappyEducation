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
class ProvinceButton: UIButton {
    var province: Province = .none
}

class ProvinceVC: UIViewController {
    @IBOutlet weak var firstButton: ProvinceButton!
    @IBOutlet weak var secondButton: ProvinceButton!
    @IBOutlet weak var thirdButton: ProvinceButton!
    @IBOutlet weak var forthButton: ProvinceButton!
    @IBOutlet weak var fifthButton: ProvinceButton!
    @IBOutlet weak var sixButton: ProvinceButton!
    @IBOutlet weak var sevenButton: ProvinceButton!
    @IBOutlet weak var eightButton: ProvinceButton!
    @IBOutlet weak var nineButton: ProvinceButton!
    @IBOutlet weak var nextButton: UIButton!
    var selectedProvinces: Set<Province> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        firstButton.province = .central
        secondButton.province = .eastern
        thirdButton.province = .nothCentral
        forthButton.province = .nothern
        fifthButton.province = .nothWestern
        sixButton.province = .sabaragamuwa
        sevenButton.province = .southern
        eightButton.province = .uva
        nineButton.province = .western
        nextButton.isEnabled = false
    }
    func validateProvince() {
        let buttons: [ProvinceButton] = [firstButton, secondButton, thirdButton, forthButton, fifthButton, sixButton, sevenButton, eightButton, nineButton]
        for button in buttons {
            let province = button.province
            if selectedProvinces.contains(province) {
                button.backgroundColor = .systemIndigo
                button.tintColor = .white
            } else {
                button.backgroundColor = .systemGray6
                button.tintColor = .darkGray
            }
        }
        if selectedProvinces.count >= 1 {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    func onProvinceChanged(province: Province) {
        if selectedProvinces.contains(province) {
            selectedProvinces.remove(province)
        } else {
            if selectedProvinces.count < 3 {
                selectedProvinces.insert(province)
            }
        }
        validateProvince()
    }
        @IBAction func firstButtonClicked(_ sender: Any) {
            onProvinceChanged(province: .central)
        }
        @IBAction func secondButtonClicked(_ sender: Any) {
            onProvinceChanged(province: .eastern)
        }
        @IBAction func thirdButtonClicked(_ sender: Any) {
            onProvinceChanged(province: .nothCentral)
        }
        @IBAction func forthButtonClicked(_ sender: Any) {
            onProvinceChanged(province: .nothern)
        }
        @IBAction func fifthButtonClicked(_ sender: Any) {
            onProvinceChanged(province: .nothWestern)
        }
        @IBAction func sixButtonClicked(_ sender: Any) {
            onProvinceChanged(province: .sabaragamuwa)
        }
        @IBAction func sevenButtonClicked(_ sender: Any) {
            onProvinceChanged(province: .southern)
        }
        @IBAction func eightButtonClicked(_ sender: Any) {
            onProvinceChanged(province: .uva)
        }
        @IBAction func nineButtonClicked(_ sender: Any) {
            onProvinceChanged(province: .western)
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
