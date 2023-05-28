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
        print(alarmlist)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTap))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.tableView.addGestureRecognizer(tapGesture)
        
        
        
    }
    
    @objc func cellTap(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: self.tableView)

        if let indexPath = self.tableView.indexPathForRow(at: tapLocation) {
            let tappedCell = self.tableView.cellForRow(at: indexPath)!
            
            UIView.animate(withDuration: 1.0, delay: 0.0, /*options: [.transitionFlipFromBottom, .curveEaseInOut],*/ animations: {
                print("animate호출")
                tappedCell.backgroundColor = UIColor.cyan
                
                tappedCell.frame = CGRect(x: 0.0 ,y: tappedCell.frame.minY ,width: 0.0, height: tappedCell.frame.height)
                self.tableView.layoutIfNeeded()
                
            }, completion: {finished in
                if indexPath.row <= self.alarmlist.count {
                    self.alarmlist.remove(at: indexPath.row)
                } else {
                    print("errorerror")
                }
                print(self.alarmlist)
                UserDefaults.standard.set(self.alarmlist, forKey: "Alarm")
                UserDefaults.standard.synchronize()
                tappedCell.backgroundColor = UIColor.white
                self.tableView.reloadData()
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.standard.set(alarmlist, forKey: "Alarm")
        UserDefaults.standard.synchronize()
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
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 1.0, delay: 0.0, /*options: [.transitionFlipFromBottom, .curveEaseInOut],*/ animations: {
            print("animate호출")
            self.tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.cyan
            
            self.tableView.cellForRow(at: indexPath)?.frame = CGRect(x: 0.0 ,y: self.tableView.cellForRow(at: indexPath)!.frame.minY ,width: 0.0, height: self.tableView.cellForRow(at: indexPath)!.frame.height)
            self.tableView.layoutIfNeeded()
            
        }, completion: {finished in
            print(self.alarmlist.remove(at: indexPath.row))
            print(self.alarmlist)
            UserDefaults.standard.set(self.alarmlist, forKey: "Alarm")
            UserDefaults.standard.synchronize()
            self.tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.white
            self.tableView.reloadData()
        })
    }
    */
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
