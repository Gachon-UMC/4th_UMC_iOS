//
//  CollectionViewCell.swift
//  Instagram
//
//  Created by YOUJIM on 2023/04/29.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with model: Model) {
        
        //self.imageView.setImage(model.imagename , for: .normal)
        self.nameLabel.text = model.id
        
    }

}
