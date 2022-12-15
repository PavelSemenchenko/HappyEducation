//
//  ViewController.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 12.12.2022.
//

import UIKit

class ViewController: UIViewController {

    // 2 SignInVc
    // 2 HomeVC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // SignUpButtonClicked.layer.cornerRadius = 12
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        guard let signUp = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") as? SignUpVC else {
            return
        }
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    
    @IBAction func skipSignUpButton(_ sender: Any) {
        guard let skip = self.storyboard?.instantiateViewController(withIdentifier: "SignIn") as? SignInVC else {
            return
        }
        self.navigationController?.pushViewController(skip, animated: true)
    }
    
}
