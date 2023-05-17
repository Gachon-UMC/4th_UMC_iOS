//
//  firstCollectionViewCell.swift
//  Instagram
//
//  Created by YOUJIM on 2023/04/29.
//

import UIKit

class firstCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var tintedButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tintedButton.layer.cornerRadius = 0.5 * tintedButton.bounds.size.width
        tintedButton.clipsToBounds = true
        tintedButton.backgroundColor = UIColor(red: 8.0/255.0, green: 225.0/255.0, blue: 114.0/255.0, alpha: 1.0)
        
        whiteButton.layer.cornerRadius = 0.5 * whiteButton.bounds.size.width
        whiteButton.clipsToBounds = true
        // Initialization code
    }
    
    public func configure(with model: Model){
        self.profileImage.setImage(model.imagename, for: .normal)
        self.titleLabel.text = model.id
        self.plusButton.isHidden = model.isNotMine
    }
    
    // 버튼 눌리면 스토리 뜨게 하는 코드
    @IBAction func buttonTapped(_ sender: Any) {
        //새로운 화면 present
        let storyVC = storyViewController()
        UIApplication.shared.keyWindow?.rootViewController?.present(storyVC, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            storyVC.dismiss(animated: true, completion: nil)
        }
        
    }
    
}

