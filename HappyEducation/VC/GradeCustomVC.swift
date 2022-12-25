//
//  GradeCustomVC.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 16.12.2022.
//

import Foundation
import UIKit

class GradeCustumVC: UIViewController {
    lazy var gradeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 16, y: 100, width: 300, height: 36))
        label.text = "What's your grade?"
        label.backgroundColor = UIColor.brown
        label.layer.borderColor = UIColor.green.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var gradeFirst: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}
