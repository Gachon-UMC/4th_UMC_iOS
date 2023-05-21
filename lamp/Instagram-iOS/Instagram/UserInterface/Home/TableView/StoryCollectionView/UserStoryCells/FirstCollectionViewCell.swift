//
//  StoryCollectionViewCell.swift
//  Instagram
//
//  Created by 박민서 on 2023/04/30.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var White_View: UIView!
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        White_View.layer.cornerRadius = 0.5 * White_View.bounds.size.width
        White_View.clipsToBounds = true
    }
    
}
