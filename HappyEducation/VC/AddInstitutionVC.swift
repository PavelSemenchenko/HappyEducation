//
//  AddInstitutionVC.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 18.01.2023.
//

import Foundation
import UIKit
import Photos
import PhotosUI

class AddInstitutionVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    let institutionRepository: InstitutionRepository = FirebaseInstitutionRepository()
    var onCreateCompletion: ((Institution?) -> Void)?
    
    @IBOutlet weak var addInstitutionImageView: UIImageView!
    @IBOutlet weak var addInstitutionNameTextField: UITextField!
    @IBOutlet weak var addInstitutionRatingTextField: UITextField!
    @IBOutlet weak var addInstitutionVotedTextField: UITextField!
    @IBOutlet weak var addInstitutionSubjectTextField: UITextField!
    @IBOutlet weak var addInstitutionDescriptionTextField: UITextField!
    
    @IBOutlet weak var addInstitutionView: UIView!
    var photoURL: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /*
        addInstitutionView.layer.shadowOpacity = 1
        addInstitutionView.layer.shadowRadius = 12.0
        addInstitutionView.layer.shadowOffset = CGSize.zero
        addInstitutionView.layer.shadowColor = UIColor.gray.cgColor
         */
    }
    
    @IBAction func addInstitutionImageClicked(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .savedPhotosAlbum
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @IBAction func addInstitutionButtonClicked(_ sender: Any) {
        guard let name = addInstitutionNameTextField.text , name.count > 3 else {
            return
        }
        guard let subject = addInstitutionSubjectTextField.text else {
            return
        }
        let rating = (addInstitutionRatingTextField.text! as NSString).integerValue
        
        let voted = (addInstitutionVotedTextField.text! as NSString).integerValue
        
        guard let description = addInstitutionDescriptionTextField.text else {
            return
        }
        
        guard let image = photoURL else {
            return
        }
        let newInstitution = institutionRepository.createInstitution(name: name,
                                                                     image: image,
                                                                     description: description,
                                                                     rating: Double(rating),
                                                                     voted: voted,
                                                                     subject: subject)
        
        self.onCreateCompletion?(newInstitution)
        self.navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoURL = info[.imageURL] as? URL
        
        guard let image = photoURL else {
            return
        }
        addInstitutionImageView.af.setImage(withURL: image)
    }
}
