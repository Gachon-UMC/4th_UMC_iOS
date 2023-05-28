//
//  ViewController.swift
//  Alarm-6-3
//
//  Created by 이재혁 on 2023/05/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var firstLabel: UILabel!
    var isFirstRunning: Bool!
    var firstTimer: Timer!
    
    var buttonClickTimes: [Date] = []
    
    @IBAction func pressStartBtn(_ sender: Any) {
        var countDown = Int(datePicker.countDownDuration)
        
        UIView.animate(withDuration: 0.3) {
            self.startButton.backgroundColor = .purple
            self.quitButton.backgroundColor = .purple
        }
        
        isFirstRunning = true
        DispatchQueue.global().async {
            let runLoop = RunLoop.current
            self.firstTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { [weak self] timer in
                countDown -= 1
                DispatchQueue.main.async {
                    let hour = countDown / 3600
                    let minute = (countDown % 3600) / 60
                    let second = (countDown % 3600) % 60
                    self?.firstLabel.text = "\(hour)시간 \(minute)분 \(second)초"
                }
                if countDown <= 0 {
                    self?.isFirstRunning = false
                    timer.invalidate()
                    DispatchQueue.main.async {
                        self?.firstLabel.text = "🚨🚨🚨"
                        // start background color animation
                        var colorChangeCount = 0
                        let colorChangeMaxCount = 5
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
                            if colorChangeCount >= colorChangeMaxCount * 2 {
                                UIView.animate(withDuration: 0.5) {
                                    self?.view.backgroundColor = .systemBackground // reset to default color
                                }
                                timer.invalidate()
                            } else {
                                UIView.animate(withDuration: 0.5) {
                                    self?.view.backgroundColor = (colorChangeCount % 2 == 0) ? .red : .blue
                                }
                                colorChangeCount += 1
                            }
                        }
                    }
                    return
                }
            })
            while self.isFirstRunning {
                runLoop.run(until: Date().addingTimeInterval(0.1))
            }
        }
        let currentTime = Date()
        buttonClickTimes.append(currentTime)
        UserDefaults.standard.set(buttonClickTimes, forKey: "ButtonClickTimes")
        
        //update tableview
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func pressQuitBtn(_ sender: Any) {
        isFirstRunning = false
        firstTimer.invalidate()
        firstLabel.text = "알람 설정"
        UIView.animate(withDuration: 0.3) {
            self.startButton.backgroundColor = .systemBackground
            self.quitButton.backgroundColor = .systemBackground
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let savedTimes = UserDefaults.standard.array(forKey: "ButtonClickTimes") as? [Date] {
            buttonClickTimes = savedTimes
        }
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonClickTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath)
                
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeString = dateFormatter.string(from: buttonClickTimes[indexPath.row])
        cell.textLabel?.text = timeString
                
                return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform.identity
        }
    }

    
}
