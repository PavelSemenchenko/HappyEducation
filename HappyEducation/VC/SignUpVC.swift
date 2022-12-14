//
//  SignUpVC.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 13.12.2022.
//

import Foundation
import UIKit

class SignUpVC: UIViewController, BaseAuthentiticationVC {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: EmailTextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    
    let authenticationService: AuthentiticationService = FirebaseAuthentiticationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signUpButtonclicked(_ sender: Any) {
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        guard let login = self.storyboard?.instantiateViewController(withIdentifier: "SignIn") as? SignInVC else { return
            
        }
        self.navigationController?.pushViewController(login, animated: true)
    }
    
}
