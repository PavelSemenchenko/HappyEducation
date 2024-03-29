//
//  HomeVC.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 13.12.2022.
//

import Foundation
import UIKit

enum Subject {
    case biology
    case math
    case physics
    case geometry
    case none
}
enum CustomSearch {
    case on
    case none
}

let subjects = ["Biology", "Math", "Physics", "Geometry"]

class HomeVC: UIViewController, UICollectionViewDelegate {
    // Custom subject select search
    var subject: Subject = .none
    var customSearch: CustomSearch = .none
    
    @IBOutlet weak var geometrySearch: UIButton!
    @IBOutlet weak var physicsSearch: UIButton!
    @IBOutlet weak var mathSearch: UIButton!
    @IBOutlet weak var biologySearch: UIButton!
    
    @IBOutlet weak var customTeachersSearchView: UIView!
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
    
    var teachers: [Teacher] = []
    
    func validateCustomSearch() {
        if customSearch == .on {
            customTeachersSearchView.isHidden = false
        } else if customSearch == .none {
            customTeachersSearchView.isHidden = true
        }
    }
    
    func validateSubjects() {
        if subject == .biology {
            biologySearch.backgroundColor = .systemIndigo
            biologySearch.tintColor = .white
            mathSearch.backgroundColor = .systemGray6
            mathSearch.tintColor = .darkGray
            physicsSearch.backgroundColor = .systemGray6
            physicsSearch.tintColor = .darkGray
            geometrySearch.backgroundColor = .systemGray6
            geometrySearch.tintColor = .darkGray
        } else if subject == .math {
            biologySearch.backgroundColor = .systemGray6
            biologySearch.tintColor = .darkGray
            mathSearch.backgroundColor = .systemIndigo
            mathSearch.tintColor = .white
            physicsSearch.backgroundColor = .systemGray6
            physicsSearch.tintColor = .darkGray
            geometrySearch.backgroundColor = .systemGray6
            geometrySearch.tintColor = .darkGray
        } else if subject == .physics {
            biologySearch.backgroundColor = .systemGray6
            biologySearch.tintColor = .darkGray
            mathSearch.backgroundColor = .systemGray6
            mathSearch.tintColor = .darkGray
            physicsSearch.backgroundColor = .systemIndigo
            physicsSearch.tintColor = .white
            geometrySearch.backgroundColor = .systemGray6
            geometrySearch.tintColor = .darkGray
        } else if subject == .geometry {
            biologySearch.backgroundColor = .systemGray6
            biologySearch.tintColor = .darkGray
            mathSearch.backgroundColor = .systemGray6
            mathSearch.tintColor = .darkGray
            physicsSearch.backgroundColor = .systemGray6
            physicsSearch.tintColor = .darkGray
            geometrySearch.backgroundColor = .systemIndigo
            geometrySearch.tintColor = .white
        } else if subject == .none {
            biologySearch.backgroundColor = .systemGray6
            biologySearch.tintColor = .darkGray
            mathSearch.backgroundColor = .systemGray6
            mathSearch.tintColor = .darkGray
            physicsSearch.backgroundColor = .systemGray6
            physicsSearch.tintColor = .darkGray
            geometrySearch.backgroundColor = .systemGray6
            geometrySearch.tintColor = .darkGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTeachersSearchView.isHidden = true
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
        
        userNameLabel.text = authenticationService.userDisplayName()
        
        // add shadow to search teacher field
        teacherSearchTextField.layer.shadowOpacity = 1
        teacherSearchTextField.layer.shadowRadius = 12.0
        teacherSearchTextField.layer.shadowOffset = CGSize.zero
        teacherSearchTextField.layer.shadowColor = UIColor.systemGray4.cgColor
        
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
            self.teachersDataSource.allTeachers = teachers
            self.teachersCollectionView.reloadData()
        }
        
        institutionsRepository.getAll { institutions in
            self.institutionsDataSource.institutions = institutions
            self.institutionsCollectionView.reloadData()
        }
    }
    // textfield search teacher
    @IBAction func searchTeacherTextField(_ sender: Any) {
        guard let searchName = teacherSearchTextField.text?.lowercased() else { return }
        if searchName.isEmpty {
            teachersDataSource.filtering = false
            teachersCollectionView.reloadData()
            return
        }
        var searchTeachers: [Teacher] = []
        for teacher in teachersDataSource.allTeachers {
            if teacher.name.lowercased().contains(searchName) {
                searchTeachers.append(teacher)
            }
        }
        teachersDataSource.filteredTeachers = searchTeachers
        teachersDataSource.filtering = true
        teachersCollectionView.reloadData()
    }
    
    // subjects buttons
    @IBAction func biologySearchButtonClicked(_ sender: Any) {
        if subject == .biology {
            subject = .none
            
            teachersDataSource.filtering = false
            teachersCollectionView.reloadData()
            
        } else {
            subject = .biology
            
            var searchTeachers: [Teacher] = []
            for teacher in teachersDataSource.allTeachers {
                if teacher.subject.lowercased().contains("biology") {
                    searchTeachers.append(teacher)
                }
            }
            teachersDataSource.filteredTeachers = searchTeachers
            teachersDataSource.filtering = true
            teachersCollectionView.reloadData()
            
        }
        validateSubjects()
        biologySearch.layer.cornerRadius = 10
        
    }
    @IBAction func mathSearchButtonClicked(_ sender: Any) {
        if subject == .math {
            subject = .none
            
            teachersDataSource.filtering = false
            teachersCollectionView.reloadData()
            
        } else {
            subject = .math
            
            var searchTeachers: [Teacher] = []
            for teacher in teachersDataSource.allTeachers {
                if teacher.subject.lowercased().contains("math") {
                    searchTeachers.append(teacher)
                }
            }
            teachersDataSource.filteredTeachers = searchTeachers
            teachersDataSource.filtering = true
            teachersCollectionView.reloadData()
            
        }
        validateSubjects()
        mathSearch.layer.cornerRadius = 10
    }
    @IBAction func physicsSerachButtonClicked(_ sender: Any) {
        if subject == .physics {
            subject = .none
            
            teachersDataSource.filtering = false
            teachersCollectionView.reloadData()
            
        } else {
            subject = .physics
            
            var searchTeachers: [Teacher] = []
            for teacher in teachersDataSource.allTeachers {
                if teacher.subject.lowercased().contains("physics") {
                    searchTeachers.append(teacher)
                }
            }
            teachersDataSource.filteredTeachers = searchTeachers
            teachersDataSource.filtering = true
            teachersCollectionView.reloadData()
            
        }
        validateSubjects()
        physicsSearch.layer.cornerRadius = 10
    }
    @IBAction func geometrySearchButtonClicked(_ sender: Any) {
        if subject == .geometry {
            subject = .none
            
            teachersDataSource.filtering = false
            teachersCollectionView.reloadData()
            
        } else {
            subject = .geometry
            
            var searchTeachers: [Teacher] = []
            for teacher in teachersDataSource.allTeachers {
                if teacher.subject.lowercased().contains("geometry") {
                    searchTeachers.append(teacher)
                }
            }
            teachersDataSource.filteredTeachers = searchTeachers
            teachersDataSource.filtering = true
            teachersCollectionView.reloadData()
            
        }
        validateSubjects()
        geometrySearch.layer.cornerRadius = 10
    }
    
    
    
    @IBAction func teacherSearchButtonClicked(_ sender: Any) {
    }
    
    @IBAction func teacherSearchCustomFilterButtonClicked(_ sender: Any) {
        if customSearch == .on {
            customSearch = .none
            // сброс тичер
            teachersDataSource.filtering = false
            teachersCollectionView.reloadData()
            
        } else {
            customSearch = .on
        }
        validateCustomSearch()
    }
    
    @IBAction func popularTeacherSearchButtonClicked(_ sender: Any) {
    }
    
    @IBAction func populatInstitutionsButtonClicked(_ sender: Any) {
    }
    
    @IBAction func addTeacherButtonClicked(_ sender: Any) {
        // назначить контроллер
        // получить данные
        // перерисовать таблицу
        
        let sbAddTeacher = UIStoryboard(name: "AddTeacherSB", bundle: nil)
        let ctlAddTeacher = sbAddTeacher.instantiateViewController(withIdentifier: "addTeacher") as! AddTeacherVC
        ctlAddTeacher.onCreateCompletion = { newTeacher in
            if let teacher = newTeacher {
                self.teachersDataSource.allTeachers.append(teacher)
                self.teachersCollectionView.reloadData()
            }
        }
        self.navigationController?.pushViewController(ctlAddTeacher, animated: true)
    }
    
    @IBAction func addInstitutionButtonClicked(_ sender: Any) {
        let sbAddInstitution = UIStoryboard(name: "AddInstitutionSB", bundle: nil)
        let ctlAddInstitution = sbAddInstitution.instantiateViewController(withIdentifier: "addInstitution") as! AddInstitutionVC
        ctlAddInstitution.onCreateCompletion = { newInstitution in
            if let institution = newInstitution {
                self.institutionsDataSource.institutions.append(institution)
                self.institutionsCollectionView.reloadData()
            }
        }
        self.navigationController?.pushViewController(ctlAddInstitution, animated: true)
    }
    
}

class TeachersDataSource: NSObject, UICollectionViewDataSource {
    var allTeachers: [Teacher] = []
    var filteredTeachers: [Teacher] = []
    var filtering = false
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filtering {
            return filteredTeachers.count
        }
        return allTeachers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeachersCellId", for: indexPath) as! TeacherCell
        // если в режиме фильтра - отображаем список отсортированных в ячейку
        if filtering {
            cell.teacher = filteredTeachers[indexPath.row]
        } else {
            cell.teacher = allTeachers[indexPath.row]
        }
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
