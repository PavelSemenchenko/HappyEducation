//
//  HomeVC.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 13.12.2022.
//

import Foundation
import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate {
    // About User
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var greatingLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    // Search techer
    @IBOutlet weak var teacherSearchTextField: UITextField!
    // Custom search
    @IBOutlet weak var teachersSearchCustomButton: UIButton!
    
    @IBOutlet weak var popularTeacherSearchButton: UIButton!
    @IBOutlet weak var popularInstitutionsSearchButton: UIButton!
    
    @IBOutlet weak var teachersCollectionView: UICollectionView!
    @IBOutlet weak var institutionsCollectionView: UICollectionView!
    
    let teachersRepository: TeachersRepository = FirebaseTeachersRepository()
    let institutionsRepository: InstitutionRepository = FirebaseInstitutionRepository()
    let authenticationService: AuthentiticationService = FirebaseAuthentiticationService()
    
    let teachersDataSource = TeachersDataSource()
    let institutionsDataSource = InstitutionsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // try change greating
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)

        var currentTime = hour
        switch currentTime {
        case 6...11: greatingLabel.text = "Good morning !"
        case 12...16: greatingLabel.text = "Good day !"
        case 17...23: greatingLabel.text = "Good evening !"
        case 0...5: greatingLabel.text = "Good night !"
        default: print("Good time")
        }
        
        //greatingLabel.text = "Greating !"
        
        userNameLabel.text = authenticationService.userDisplayName()
        
        // hide back bar
        navigationItem.setHidesBackButton(true, animated: true)
        // logout in nav bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut",
                                                            style: UIBarButtonItem.Style.plain,
                                                            target: self,
                                                            action: #selector(logOutClicked))
        // register cells
        teachersCollectionView.register(UINib(nibName: "TeacherCell", bundle: nil)
                                        , forCellWithReuseIdentifier: "TeachersCellId")
        teachersCollectionView.dataSource = teachersDataSource
        institutionsCollectionView.register(UINib(nibName: "InstitutionCell", bundle: nil)
                                            , forCellWithReuseIdentifier: "InstitutionCellId")
        institutionsCollectionView.dataSource = institutionsDataSource
        loadAll()
    }
    @objc func logOutClicked() {
        authenticationService.logOut()
        if navigationController?.viewControllers.count == 1 {
            guard let viewController = storyboard?.instantiateViewController(withIdentifier: "viewController") else {
                return
            }
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func loadAll() {
        teachersRepository.getAll { teachers in
            self.teachersDataSource.teachers = teachers
            self.teachersCollectionView.reloadData()
        }
        
        institutionsRepository.getAll { institutions in
            self.institutionsDataSource.institutions = institutions
            self.institutionsCollectionView.reloadData()
        }
    }
    
    @IBAction func teacherSearchButtonClicked(_ sender: Any) {
    }
    
    @IBAction func teacherSearchCustomFilterButtonClicked(_ sender: Any) {
    }
    
    @IBAction func popularTeacherSearchButtonClicked(_ sender: Any) {
    }
    
    @IBAction func populatInstitutionsButtonClicked(_ sender: Any) {
    }
    
    @IBAction func addTeacherButtonClicked(_ sender: Any) {
        // назначить контроллер
        // получить данные
        // перерисовать таблицу
        let newTeacher = AddTeacherVC()
        newTeacher.onCreateCompletion = { newTeacher in
            if let teacher = newTeacher {
                self.teachersDataSource.teachers.append(teacher)
                self.teachersCollectionView.reloadData()
            }
        }
        let sbAddTeacher = UIStoryboard(name: "AddTeacherSB", bundle: nil)
        let ctlAddTeacher = sbAddTeacher.instantiateViewController(withIdentifier: "addTeacher")
        self.navigationController?.pushViewController(ctlAddTeacher, animated: true)
    }
    
    @IBAction func addInstitutionButtonClicked(_ sender: Any) {
        let newInstitution = AddInstitutionVC()
        newInstitution.onCreateCompletion = { newInstitution in
            if let institution = newInstitution {
                self.institutionsDataSource.institutions.append(institution)
                self.institutionsCollectionView.reloadData()
            }
        }
        let sbAddInstitution = UIStoryboard(name: "AddInstitutionSB", bundle: nil)
        let ctlAddInstitution = sbAddInstitution.instantiateViewController(withIdentifier: "addInstitution")
        self.navigationController?.pushViewController(ctlAddInstitution, animated: true)
    }
    
}

class TeachersDataSource: NSObject, UICollectionViewDataSource {
    var teachers: [Teacher] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teachers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeachersCellId", for: indexPath) as! TeacherCell
        
        cell.teacher = teachers[indexPath.row]
        return cell
    }
}

class InstitutionsDataSource: NSObject, UICollectionViewDataSource {
    var institutions: [Institution] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return institutions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstitutionCellId", for: indexPath) as! InstitutionCell
        
        cell.institution = institutions[indexPath.row]
        return cell
    }
}
