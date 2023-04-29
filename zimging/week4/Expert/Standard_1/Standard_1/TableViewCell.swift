//
//  TableViewCell.swift
//  Standard_1
//
//  Created by YOUJIM on 2023/04/29.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var orgLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
