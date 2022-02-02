//
//  HomeTableViewCell.swift
//  PhotoSharingApp
//
//  Created by Yağız Savran on 2.02.2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var emailText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
