//
//  AddTeacherVC.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 16.01.2023.
//

import Foundation
import UIKit
import Photos
import PhotosUI

class AddTeacherVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let teacherRepository: TeachersRepository = FirebaseTeachersRepository()
    var onCreateCompletion: ((Teacher?) -> Void)?
    
    @IBOutlet weak var addTeacherView: UIView!
    @IBOutlet weak var addTeacherImageView: UIImageView!
    
    @IBOutlet weak var addTeacherImageURL: UITextField!
    
    @IBOutlet weak var addTeacherUserNameTextField: UITextField!
    @IBOutlet weak var addTeacherSubjectTextField: UITextField!
    
    var photoURL: URL?
    
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
        let vc = UIImagePickerController()
        vc.sourceType = .savedPhotosAlbum
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
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
        guard let image = photoURL else {
            return
        }
        
        let newTeacher = teacherRepository.createTeacher(name: name, subject: subject, image: image)
        self.onCreateCompletion?(newTeacher)
        self.navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        photoURL = info[.imageURL] as? URL
        
        guard let image = photoURL else {
            return
        }
        addTeacherImageView.af.setImage(withURL: image)
    }
}
