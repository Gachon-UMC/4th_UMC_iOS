//
//  StoryTableViewCell.swift
//  Instagram
//
//  Created by 박민서 on 2023/04/29.
//

import UIKit

class StoryTableViewCell: UITableViewCell {
    @IBOutlet weak var StroyImage: UIImageView!
    @IBOutlet weak var StroyPlus: UIButton!
    @IBOutlet weak var Username: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // contentView를 90도 회전시킵니다.
        self.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
