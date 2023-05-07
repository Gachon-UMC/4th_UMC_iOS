//
//  StoryCollectionViewCell.swift
//  Instagram
//
//  Created by 박민서 on 2023/04/30.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var Color_view: UIView!
    @IBOutlet weak var White_View: UIView!
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Color_view.layer.cornerRadius = 0.5 * Color_view.bounds.size.width
        Color_view.clipsToBounds = true
        White_View.layer.cornerRadius = 0.5 * White_View.bounds.size.width
        White_View.clipsToBounds = true
        UserImage.layer.cornerRadius = 0.5 * UserImage.bounds.size.width
        UserImage.clipsToBounds = true
        
    }

}
