//
//  TableViewCell.swift
//  Instagram
//
//  Created by 이재혁 on 2023/05/04.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var commentCount: UILabel!
    
    @IBOutlet weak var Nakami: UILabel!
    
    @IBOutlet weak var feedUserID: UILabel!
    
    @IBOutlet weak var likeCount: UILabel!
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var profileID: UILabel!
    
    @IBOutlet weak var feedImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
//    }
    
}

/**
 class TestListCell: UICollectionViewCell {

     @IBOutlet weak var testImage: UIImageView!
     
     override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
     }

 }
 
 */
