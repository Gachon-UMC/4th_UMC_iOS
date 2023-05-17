//
//  ViewController.swift
//  Standard_1
//
//  Created by YOUJIM on 2023/05/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var wakeUpField: UITextField!
    @IBOutlet weak var goToSchoolTime: UILabel!
    @IBOutlet weak var eatMealTime: UILabel!
    @IBOutlet weak var recordTable: UITableView!
    @IBOutlet weak var setButton: UIButton!
    
    var records = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordTable.dataSource = self
        recordTable.delegate = self
    }

    @IBAction func wakeUpButton(_ sender: UIButton) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        records.append(formatter.string(from: Date()))
        UserDefaults.standard.set(records, forKey: "buttonState")
        recordTable.reloadData()
        
        let semaphore = DispatchSemaphore(value: 3)
        var timeToWake = 0
        
        let wakeAlert = UIAlertController(title: "일어날 시간이예요!", message: "지금 안 일어나면 밥을 못 먹어요!", preferredStyle: UIAlertController.Style.alert)
        wakeAlert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default))
        
        let mealAlert = UIAlertController(title: "밥먹을 시간이예요!", message: "아직도 안 일어나신 건 아니죠?", preferredStyle: UIAlertController.Style.alert)
        mealAlert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default))
        
        let schoolAlert = UIAlertController(title: "학교 갈 시간이예요!", message: "화이팅!", preferredStyle: UIAlertController.Style.alert)
        schoolAlert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default))
        
        timeToWake = Int(wakeUpField.text!)!
        goToSchoolTime.text = String(timeToWake + 90)
        eatMealTime.text = String(timeToWake + 45)
        
        for i in 1...3 {
            semaphore.wait()
            DispatchQueue.global().async {
                if i == 1 {
                    Thread.sleep(forTimeInterval: TimeInterval(timeToWake))
                    DispatchQueue.main.async {
                        self.present(wakeAlert, animated: false)
                    }
                }
                else if i == 2 {
                    Thread.sleep(forTimeInterval: TimeInterval(timeToWake + 4))
                    DispatchQueue.main.async {
                        self.present(mealAlert, animated: false)
                    }
                }
                else if i == 3 {
                    Thread.sleep(forTimeInterval: TimeInterval(timeToWake + 9))
                    DispatchQueue.main.async {
                        self.present(schoolAlert, animated: false)
                    }
                }
                semaphore.signal()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath)
        
        cell.textLabel?.text = UserDefaults.standard.array(forKey: "buttonState")?[indexPath.row] as? String
        
        return cell
    }
}
