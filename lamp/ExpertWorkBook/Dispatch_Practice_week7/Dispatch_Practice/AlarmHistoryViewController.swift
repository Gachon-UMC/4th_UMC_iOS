//
//  AlarmHistoryViewController.swift
//  Dispatch_Practice
//
//  Created by 박민서 on 2023/05/17.
//

import Foundation
import UIKit


class AlarmHistoryViewController: UITableViewController{
    
    var alarmlist:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let Ulist = UserDefaults.standard
        alarmlist += Ulist.stringArray(forKey: "Alarm") ?? ["Error"]
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
           // #warning Incomplete implementation, return the number of sections
           return 1 //섹션 수
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return alarmlist.count //테이블 뷰 셀 수
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmHistoryCell", for: indexPath) as! AlarmHistoryCell
        cell.AlarmText.text = alarmlist[indexPath.row]

           return cell
       }
}

class AlarmHistoryCell: UITableViewCell {
    
    @IBOutlet weak var AlarmText: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
