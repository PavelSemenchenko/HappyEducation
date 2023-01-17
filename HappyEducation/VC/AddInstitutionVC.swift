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
    var onCreateCompletion: ((Teacher?) -> Void)?
    
    @IBOutlet weak var addInstitutionImageView: UIImageView!
    @IBOutlet weak var addInstitutionNameTextField: UITextField!
    @IBOutlet weak var addInstitutionRatingTextField: UITextField!
    @IBOutlet weak var addInstitutionVotedTextField: UITextField!
    @IBOutlet weak var addInstitutionSubjectTextField: UITextField!
    @IBOutlet weak var addInstitutionDescriptionTextField: UITextField!
    
    
    
    
    @IBAction func addInstitutionImageClicked(_ sender: Any) {
    }
    
    @IBAction func addInstitutionButtonClicked(_ sender: Any) {
    }
}
