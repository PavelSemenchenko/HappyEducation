//
//  ViewController.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 12.12.2022.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func signUpButtonClicked(_ sender: Any) {
        guard let signUp = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") as? SignUpVC else {
            return
        }
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    @IBAction func skipSignUpButton(_ sender: Any) {
        guard let skip = self.storyboard?.instantiateViewController(withIdentifier: "GradeSelectVC") as? GradeSelectVC else {
            return
        }
        self.navigationController?.pushViewController(skip, animated: true)
    }
}
