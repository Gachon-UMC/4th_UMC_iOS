//
//  firstCollectionViewCell.swift
//  Instagram
//
//  Created by 이재혁 on 2023/05/07.
//

import UIKit

class firstCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //borderView.layer.cornerRadius = CGFloat(borderView.frame.width) / 2.0
        borderView.layer.cornerRadius = borderView.frame.width / 2.0
        borderView.layer.borderWidth = 3.0

        borderView.layer.borderColor = CGColor(red: 8.0/255.0, green: 255.0/255.0, blue: 114.0/255.0, alpha: 1.0)
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2.0
        //profileImage.layer.borderWidth = 3
        //profileImage.layer.borderColor = CGColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        // Initialization code
    }
    
    //MARK: - 데이터 모델과 연결
    public func configure(with model: Model){
        
        self.profileImage.image = UIImage(named: model.storyImage)
        self.titleLabel.text = model.userID
        self.plusButton.isHidden = model.isWatch
        if !model.isWatch {borderView.layer.borderWidth = 0}
    }


}
