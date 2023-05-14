//
//  BottomSheetTableViewCell.swift
//  Instagram
//
//  Created by 박민서 on 2023/05/11.
//

import UIKit

class BottomSheetTableViewCell: UITableViewCell {

    @IBOutlet weak var BottomSheetLabelContainer: UIView!
    @IBOutlet weak var BottomSheetTableCellImage: UIImageView!
    @IBOutlet weak var BottomSheetTableCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        BottomSheetLabelContainer.layer.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print(BottomSheetTableCellLabel.text!) //print Label Text when it is selected
    }
    
}
