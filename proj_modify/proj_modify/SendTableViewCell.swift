//
//  SendTableViewCell.swift
//  proj_modify
//
//  Created by 이경준 on 2017. 6. 14..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit

class SendTableViewCell: UITableViewCell {

    @IBOutlet weak var receiver: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var intro: UILabel!
    @IBOutlet weak var Tier_image: UIImageView!
    @IBOutlet weak var Tier_text: UILabel!
    @IBOutlet weak var Most_cham: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
