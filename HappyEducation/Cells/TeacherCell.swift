//
//  TeacherCell.swift
//  HappyEducation
//
//  Created by MakBook on 29.12.2022.
//

import UIKit
import AlamofireImage

class TeacherCell: UICollectionViewCell {

    @IBOutlet weak var teacherImageView: UIImageView!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var teacherSubjectLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var teacher: Teacher! {
        didSet {
            prepareForReuse()
        }
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        teacherNameLabel.text = teacher.name
        teacherSubjectLabel.text = teacher.subject
        guard let url = URL(string: teacher.image) else {
            teacherImageView.image = nil
            return
        }
        teacherImageView.af.setImage(withURL: url)
    }
}
