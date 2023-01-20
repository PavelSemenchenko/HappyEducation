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

class AddTeacherVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
        
    let teacherRepository: TeachersRepository = FirebaseTeachersRepository()
    var onCreateCompletion: ((Teacher?) -> Void)?
    
    @IBOutlet weak var addTeacherView: UIView!
    @IBOutlet weak var addTeacherImageView: UIImageView!
      
    @IBOutlet weak var addTeacherUserNameTextField: UITextField!
    @IBOutlet weak var addTeacherSubjectTextField: UITextField!
    
    @IBOutlet weak var subjectsView: UIPickerView!
    
    var photoURL: URL?
    
    
    var selectedSubject: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTeacherView.layer.shadowOpacity = 1
        addTeacherView.layer.shadowRadius = 12.0
        addTeacherView.layer.shadowOffset = CGSize.zero
        addTeacherView.layer.shadowColor = UIColor.systemGray4.cgColor
        
        subjectsView.dataSource = self
        subjectsView.delegate = self
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
        guard let subject = selectedSubject else {
            return
        }
        // temple image <- string
        guard let image = photoURL else {
            return
        }
        
        let newTeacher = teacherRepository.createTeacher(name: name,
                                                         subject: subject,
                                                         image: image)
        self.onCreateCompletion?(newTeacher)
        self.navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: false)
        photoURL = info[.imageURL] as? URL
        guard let image = photoURL else {
            return
        }
        addTeacherImageView.af.setImage(withURL: image)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjects[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSubject = subjects[row]
    }
}
