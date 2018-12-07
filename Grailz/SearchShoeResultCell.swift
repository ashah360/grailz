//
//  SearchShoeResultCell.swift
//  Grailz
//
//  Created by James S. Lee on 12/3/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

class SearchShoeResultCell: UITableViewCell {

  @IBOutlet weak var ShoeImageView: UIImageView!
  @IBOutlet weak var ShoeName: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
