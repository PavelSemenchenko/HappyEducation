//
//  HomeVC.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 13.12.2022.
//

import Foundation
import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var teachersFilterButton: UIButton!
    @IBOutlet weak var teachersCollectionView: UICollectionView!
    @IBOutlet weak var institutionsFilterButton: UIButton!
    @IBOutlet weak var institutionsCollectionView: UICollectionView!
    
    let teachersRepository: TeachersRepository = FirebaseTeachersRepository()
    var teachers: [Teacher] = []
    let authenticationService: AuthentiticationService = FirebaseAuthentiticationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide back bar
        navigationItem.setHidesBackButton(true, animated: true)
        // register cells
        userTableView.register(UINib(nibName: "HelloUserCel", bundle: nil)
                               , forCellReuseIdentifier: "HelloUserCel")
        teachersCollectionView.register(UINib(nibName: "TeachersCell", bundle: nil)
                                        , forCellWithReuseIdentifier: "TeachersCell")
        institutionsCollectionView.register(UINib(nibName: "InstitutionCell", bundle: nil)
                                            , forCellWithReuseIdentifier: "InstitutionCell")
        loadAll()
    }
    /*
     // tableView User
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return user?.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     }
     */
    func loadAll() {
        teachersRepository.getAll { teachers in
            self.teachers = teachers
            self.teachersCollectionView.reloadData()
        }
    }
    // collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teachers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeachersCell", for: indexPath) as! TeacherCell
        
        cell.teacher = teachers[indexPath.row]
        // cell.teacherRepository = TeachersRepository
        cell.teacherRepository = teachersRepository
        return cell
        
    }
}
