//
//  HamburgerBottomSheetTableViewCell.swift
//  Instagram
//
//  Created by 이재혁 on 2023/05/11.
//

import UIKit

class HamburgerBottomSheetTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var iconText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
