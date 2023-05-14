//
//  myTableViewCell.swift
//  ExpertWorkBook
//
//  Created by 박민서 on 2023/04/29.
//

import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImg: UIImageView!
    
    @IBOutlet weak var userStatus: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userContentLabel: UILabel!
    
    // 쎌이 랜더링(그릴때) 될때
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("MyTableViewCell - awakeFromNib() called")
        
        //userProfileImg.layer.cornerRadius = userProfileImg.frame.width / 2
        
    }
    
        override func prepareForReuse() {
            super.prepareForReuse()
            userName.text = nil
            userStatus.text = nil
            userContentLabel.text = nil
        }
    
}
