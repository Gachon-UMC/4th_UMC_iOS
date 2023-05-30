//
//  AlarmTableViewCell.swift
//  Dispatch_Practice
//
//  Created by 박민서 on 2023/05/10.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    static let identifier = "AlarmTableViewCell"
    
    @IBOutlet weak var AlarmLabel: UILabel!
    var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func startTimer(alarmDate: Date) {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                
                let timeRemaining = alarmDate.timeIntervalSince(Date()).rounded()
                let formattedTime = String(format: "%.0f", timeRemaining)
                self.AlarmLabel.text = "\(formattedTime) seconds left"
                
                if timeRemaining <= 0 {
                    timer.invalidate() //timer goes to false
                    self.AlarmLabel.text = "Alarm!"
                }
            }
        }
    
}
