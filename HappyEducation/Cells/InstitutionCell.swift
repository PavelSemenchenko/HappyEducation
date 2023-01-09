//
//  InstitutionCell.swift
//  HappyEducation
//
//  Created by MakBook on 29.12.2022.
//

import UIKit

class InstitutionCell: UICollectionViewCell {

    @IBOutlet weak var institutionNameLabel: UILabel!
    @IBOutlet weak var institutionImageVew: UIImageView!
    
    @IBOutlet weak var institutionStarsLabel: UILabel!
    
    @IBOutlet weak var institutionDescriptionTextView: UITextView!
    @IBOutlet weak var institutionVotesLabel: UILabel!
    @IBOutlet weak var institutionSubjectLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var institution: Institution! {
        didSet {
            prepareForReuse()
        }
    }
    var institutionRepository: InstitutionRepository!
    
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
