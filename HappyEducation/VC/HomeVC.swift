//
//  HomeVC.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 13.12.2022.
//

import Foundation
import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var teachersFilterButton: UIButton!
    @IBOutlet weak var teachersCollectionView: UICollectionView!
    @IBOutlet weak var institutionsFilterButton: UIButton!
    @IBOutlet weak var institutionsCollectionView: UICollectionView!
    
    let teachersRepository: TeachersRepository = FirebaseTeachersRepository()
    let institutionsRepository: InstitutionRepository = FirebaseInstitutionRepository()
    let authenticationService: AuthentiticationService = FirebaseAuthentiticationService()
    
    let teachersDataSource = TeachersDataSource()
    let institutionsDataSource = InstitutionsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide back bar
        navigationItem.setHidesBackButton(true, animated: true)
        // register cells
        teachersCollectionView.register(UINib(nibName: "TeacherCell", bundle: nil)
                                        , forCellWithReuseIdentifier: "TeachersCellId")
        teachersCollectionView.dataSource = teachersDataSource
        institutionsCollectionView.register(UINib(nibName: "InstitutionCell", bundle: nil)
                                            , forCellWithReuseIdentifier: "InstitutionCellId")
        institutionsCollectionView.dataSource = institutionsDataSource
        loadAll()
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
