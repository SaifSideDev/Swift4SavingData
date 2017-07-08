//
//  PersonTableViewCell.swift
//  Swift4SavingData
//
//  Created by Saif Khan on 7/7/17.
//  Copyright © 2017 SaifSide Inc. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
