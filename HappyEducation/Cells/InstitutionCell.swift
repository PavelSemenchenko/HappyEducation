//
//  InstitutionCell.swift
//  HappyEducation
//
//  Created by MakBook on 29.12.2022.
//

import UIKit
import AlamofireImage

class InstitutionCell: UICollectionViewCell {

    @IBOutlet weak var institutionNameLabel: UILabel!
    @IBOutlet weak var institutionImageVew: UIImageView!
    @IBOutlet weak var institutionStarsLabel: UILabel!
    @IBOutlet weak var institutionDescriptionTextView: UITextView!
    @IBOutlet weak var institutionVotesLabel: UILabel!
    @IBOutlet weak var institutionSubjectLabel: UILabel!
    @IBOutlet weak var institutionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        institutionView.layer.shadowOpacity = 1
        institutionView.layer.shadowRadius = 8.0
        institutionView.layer.shadowOffset = CGSize.zero
        institutionView.layer.shadowColor = UIColor.systemGray4.cgColor
        institutionView.layer.cornerRadius = 10
        // Initialization code
    }

    var institution: Institution! {
        didSet {
            prepareForReuse()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        institutionNameLabel.text = institution.name
        institutionStarsLabel.text = String(institution.rating)
        institutionVotesLabel.text = String(institution.voted)
        institutionSubjectLabel.text = institution.subject
        institutionDescriptionTextView.text = institution.description
        guard let url = URL(string: institution.image) else {
            institutionImageVew.image = nil
            return
        }
        institutionImageVew.af.setImage(withURL: url)
    }
}
