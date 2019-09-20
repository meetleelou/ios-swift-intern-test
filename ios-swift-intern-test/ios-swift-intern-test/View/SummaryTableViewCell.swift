//
//  SummaryTableViewCell.swift
//  iosInternTest
//
//  Created by Clark on 20/9/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    
//    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var summary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
