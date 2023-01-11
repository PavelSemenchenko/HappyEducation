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
    
    let institutionsRepository: InstitutionRepository = FirebaseInstitutionRepository()
    var intitutions: [Institution] = []
    
    let authenticationService: AuthentiticationService = FirebaseAuthentiticationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        // hide back bar
        navigationItem.setHidesBackButton(true, animated: true)
        // register cells
        userTableView.register(UINib(nibName: "HelloUserCel", bundle: nil)
                               , forCellReuseIdentifier: "HelloUserCel")
        teachersCollectionView.register(UINib(nibName: "TeacherCell", bundle: nil)
                                        , forCellWithReuseIdentifier: "TeachersCell_000")
        teachersCollectionView.dataSource = self
        institutionsCollectionView.register(UINib(nibName: "InstitutionCell", bundle: nil)
                                            , forCellWithReuseIdentifier: "InstitutionCell")
        institutionsCollectionView.dataSource = self
        loadAll()
    }
    /*
     // tableView User
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 1
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "HelloUserCell", for: indexPath) as? HelloUserCell else {
             fatalError("Cell user is bad")
         }
         // cell.data = UserProfile[indexPath.row]
     }
     */
    
#if DEBUG
    // how to repeat func loadAll for institutions?
    // how to repeat init collectionView
#endif
    
    func loadAll() {
        teachersRepository.getAll { teachers in
            self.teachers = teachers
            self.teachersCollectionView.reloadData()
        }
    }
    // Teachers collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teachers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeachersCell_000", for: indexPath) as! TeacherCell
        
        cell.teacher = teachers[indexPath.row]
        return cell
        
    }
    
    
}
