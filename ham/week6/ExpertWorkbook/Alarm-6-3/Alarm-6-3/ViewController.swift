//
//  ViewController.swift
//  Alarm-6-3
//
//  Created by 이재혁 on 2023/05/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var firstLabel: UILabel!
    var isFirstRunning: Bool!
    var firstTimer: Timer!
    
    @IBAction func pressStartBtn(_ sender: Any) {
        var countDown = Int(datePicker.countDownDuration)
        isFirstRunning = true
        DispatchQueue.global().async {
            let runLoop = RunLoop.current
            self.firstTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
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
                    }
                    return
                }
            })
            while self.isFirstRunning {
                runLoop.run(until: Date().addingTimeInterval(0.1))
            }
        }
    }
    
    @IBAction func pressQuitBtn(_ sender: Any) {
        isFirstRunning = false
        firstTimer.invalidate()
        firstLabel.text = "알람 설정"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

