//
//  SearchShoeResultCell.swift
//  Grailz
//
//  Created by Nathan Han on 12/7/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

class SearchShoeResultCell: UITableViewCell {
    
    @IBOutlet weak var ShoeName: UILabel!
    @IBOutlet weak var ShoeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
