//
//  SearchingListTableViewCell.swift
//  proj_modify
//
//  Created by 이경준 on 2017. 6. 15..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit

class SearchingListTableViewCell: UITableViewCell {

    @IBOutlet weak var plus_pic: UIView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var User_name: UILabel!
    @IBOutlet weak var User_Tier_image: UIImageView!
    @IBOutlet weak var User_Tier_Text: UILabel!
    @IBOutlet weak var User_intro: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var User_Tier_image2: UIImageView!
    @IBOutlet weak var User_Tier_Text2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
