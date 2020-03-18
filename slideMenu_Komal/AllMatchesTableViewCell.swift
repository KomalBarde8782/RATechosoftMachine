//
//  AllMatchesTableViewCell.swift
//  slideMenu_Komal
//
//  Created by Komal Barde on 27/02/2020.
//  Copyright © 2020 Komal Barde. All rights reserved.
//

import UIKit

class AllMatchesTableViewCell: UITableViewCell {

    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
