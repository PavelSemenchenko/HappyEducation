//
//  AddTeacherVC.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 16.01.2023.
//

import Foundation
import UIKit

class AddTeacherVC: UIViewController {
    let teacherRepository: TeachersRepository = FirebaseTeachersRepository()
    var onCreateCompletion: ((Teacher?) -> Void)?
    
    @IBOutlet weak var addTeacherView: UIView!
    @IBOutlet weak var addTeacherImageView: UIImageView!
    
    @IBOutlet weak var addTeacherImageURL: UITextField!
    
    @IBOutlet weak var addTeacherUserNameTextField: UITextField!
    @IBOutlet weak var addTeacherSubjectTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
                        
        /*
        addTeacherView.layer.shadowOpacity = 1
        addTeacherView.layer.shadowRadius = 12.0
        addTeacherView.layer.shadowOffset = CGSize.zero
        addTeacherView.layer.shadowColor = UIColor.gray.cgColor
         */
    }
    
        
    @IBAction func addTeacherImageClicked(_ sender: Any) {
    }
    
    
    @IBAction func addTeacherSaveClicked(_ sender: Any) {
        // make record to db
        // return to main
        // reload table of teachers
        guard let name = addTeacherUserNameTextField.text, name.count > 3 else {
            return
        }
        guard let subject = addTeacherSubjectTextField.text, subject.count > 2 else {
            return
        }
        // temple image <- string
        guard let image = addTeacherImageURL.text else {
            return
        }
        
        let newTeacher = teacherRepository.createTeacher(name: name, subject: subject, image: image)
        self.onCreateCompletion?(newTeacher)
        self.navigationController?.popViewController(animated: true)
    }
}
