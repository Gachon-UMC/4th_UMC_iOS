//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 박민서 on 2023/05/07.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserImage: UIImageView!
    //@IBOutlet weak var UserName: UIBarButtonItem!
    @IBOutlet weak var PostImage: UIImageView!
    @IBOutlet weak var PostLike: UILabel!
    @IBOutlet weak var UserID: UILabel!
    @IBOutlet weak var User_Text: UILabel!
    @IBOutlet weak var CommentCount: UILabel!
    @IBOutlet weak var PostDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UserImage.layer.cornerRadius = 0.5 * UserImage.bounds.size.width
        UserImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
