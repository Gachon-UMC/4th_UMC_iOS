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
    @IBOutlet weak var PostImage: UIImageView!
    @IBOutlet weak var PostLike: UILabel!
    @IBOutlet weak var UserID: UILabel!
    @IBOutlet weak var User_Text: UILabel!
    @IBOutlet weak var CommentCount: UILabel!
    @IBOutlet weak var PostDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UserImage.layer.cornerRadius = 0.5 * UserImage.bounds.size.width
        UserImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(_ post: post) {
        self.UserID.text = post.UserID
        self.UserName.text = post.UserID
        self.UserImage.image = UIImage(named: post.UserImage) ?? UIImage()
        self.PostImage.image = UIImage(named: post.PostImage) ?? UIImage()
        self.PostLike.text = "좋아요 \(post.PostLike)개"
        self.User_Text.text = post.UserText
        self.CommentCount.text = "댓글 \(post.CommentCount)개 모두 보기"
        self.PostDate.text = post.PostDate
    }
    
}
