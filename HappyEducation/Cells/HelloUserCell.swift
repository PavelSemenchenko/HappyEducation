//
//  HelloUserCell.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 27.12.2022.
//

import UIKit

class HelloUserCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var data: UserProfile! {
        didSet {
            
            //prepareForReuse()
        }
    }

   
    
}
