//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by YOUJIM on 2023/05/04.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    var posts = [Post]()
    
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var profileId: UIButton!
    @IBOutlet weak var ellipsis: UIButton!
    @IBOutlet weak var postImage: UIButton!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var dmBtn: UIButton!
    @IBOutlet weak var markBtn: UIButton!
    
    @IBOutlet weak var numOfLikeBtn: UIButton!
    @IBOutlet weak var postIdBtn: UIButton!
    @IBOutlet weak var postContent: UILabel!
    
    @IBOutlet weak var numOfComment: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileBtn.layer.cornerRadius = 0.5 * profileBtn.bounds.size.width
        profileBtn.clipsToBounds = true
        postIdBtn.invalidateIntrinsicContentSize()
        
        // Initialization code
    }
    
    public func configure(with post: Post){
        
        self.profileBtn.setImage(post.info.imagename, for: .normal)
        self.profileId.titleLabel?.text = post.info.id
        self.postImage.setImage(post.imageName, for: .normal)
        self.postContent.text = post.imageComment
        self.postIdBtn.titleLabel?.text = post.info.id
        
        self.numOfLikeBtn.titleLabel?.text = "좋아요 \(post.numOfLike)개"
        self.numOfComment.titleLabel?.text = "댓글 \(post.numOfComment)개 보기"
        self.dateLabel.text = "    \(post.month)월 \(post.day)일"
        
    }
}
