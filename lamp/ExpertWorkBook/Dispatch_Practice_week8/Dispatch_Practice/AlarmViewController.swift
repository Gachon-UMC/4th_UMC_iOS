//
//  AlarmViewController.swift
//  Dispatch_Practice
//
//  Created by 박민서 on 2023/05/10.
//

import UIKit
import UserNotifications

class AlarmViewController: UIViewController {
    var Alarm_list: [Date] = []
    var temp_Alarm_list: [String] = []
    var P_Alarm_list: [String] = []
    var timer: Timer?
    var isadd: Bool = false
    @IBOutlet weak var AddAlarm: UIButton!
    
    @IBAction func AlarmHistoryTapped(_ sender: Any) {
        
        if let alarm_list = UserDefaults.standard.stringArray(forKey: "Alarm") {
            P_Alarm_list = alarm_list
        }
        if isadd {
            P_Alarm_list.append(contentsOf: temp_Alarm_list)
            temp_Alarm_list = []
        }
        isadd = false
        print("P_Alarm_list : \(P_Alarm_list)")
        UserDefaults.standard.set(P_Alarm_list, forKey: "Alarm")
    }
    
    @IBAction func AlarmAddTapped(_ sender: Any) {
        setAlarm(time: 3.0)
        isadd = true
    }		
    
    @IBAction func ThrowButtonTapped(_ sender: Any) {
        UIView.transition(with: AlarmTableView, duration: 1, options: [.transitionCurlUp], animations: {
            self.Alarm_list.removeAll()
            self.temp_Alarm_list.removeAll()
            self.AlarmTableView.reloadData()
        }, completion: nil)
    }
    
    

    @IBOutlet weak var AlarmTableView: UITableView!
    let queue = DispatchQueue(label: "alarmQueue", attributes: .concurrent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuthorizationForNotification()
        self.AlarmTableView.delegate = self
        self.AlarmTableView.dataSource = self
        
//        if let alarm_list = UserDefaults.standard.stringArray(forKey: "Alarm") {
//            P_Alarm_list = alarm_list
//        }
        
        //print(P_Alarm_list)
        
        let AlarmCell = UINib(nibName: "AlarmTableViewCell", bundle: nil)
        AlarmTableView.register(AlarmCell, forCellReuseIdentifier: "AlarmTableViewCell")
        
        let ButtonTap = UITapGestureRecognizer(target: self, action: #selector(buttonTap))
        ButtonTap.numberOfTapsRequired = 1
        ButtonTap.numberOfTouchesRequired = 1
        AddAlarm.addGestureRecognizer(ButtonTap)
        
        
        
    }
    
    @objc func buttonTap(_ sender: UITapGestureRecognizer) {
        let pumpupAnimation = CABasicAnimation(keyPath: "transform.scale")
        pumpupAnimation.duration = 0.1
        pumpupAnimation.fromValue = 1.0
        pumpupAnimation.toValue = 1.1
        pumpupAnimation.autoreverses = true
        
        sender.view?.layer.add(pumpupAnimation, forKey: "pumpupAnimation")
    }
    
    
    func setAlarm(time: TimeInterval) {
        let alarmDate = Date().addingTimeInterval(time)
        Alarm_list.append(alarmDate)
        //print("너 몇번되냐")
        AlarmTableView.reloadData()
        let workItem = DispatchWorkItem {
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "알람"
            notificationContent.body = "알람이 울렸습니다."
            //print("알람이 울립니다")
            
            self.temp_Alarm_list.append("\(alarmDate)")
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: "alarm", content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if error != nil {
                    print("알림 추가 중 오류 발생")
                } else {
                    //시간이 만료되었을 때 실행
                    DispatchQueue.main.async {
                        //알람 리스트 업데이트
                        if self.timer == nil {
                            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
                        }
                        
                        // 테이블 뷰 업데이트
                        self.AlarmTableView.reloadData()
                    }
                }
            }
        }
        // setAlarm이 호출되었을때 실행
        queue.asyncAfter(deadline: .now() + time, execute: workItem)
        print("\(alarmDate) 추가됨")
    }
    
    @objc func updateTimer() {
        DispatchQueue.main.async {
            for (_, date) in self.Alarm_list.enumerated() {
                let timeLeft = Int(date.timeIntervalSinceNow)
                if timeLeft <= 0 {
                    // 알람 시간이 지난 경우
                    self.Alarm_list.removeFirst()
                }
            }
            if self.Alarm_list.isEmpty {
                // 모든 알람이 제거된 경우
                self.timer?.invalidate()
                self.timer = nil
                self.AlarmTableView.reloadData() //reloadData???? CELL??
            }
        }
    }
    
    

    func requestAuthorizationForNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("알림 권한 승인됨")
            } else {
                print("알림 권한 거부됨")
            }
        }
    }
}

extension AlarmViewController : UITableViewDelegate {
}

extension AlarmViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return Alarm_list.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmTableViewCell", for: indexPath) as? AlarmTableViewCell else { return UITableViewCell() }
            let alarmDate = Alarm_list[indexPath.row]
                cell.startTimer(alarmDate: alarmDate)
            return cell
        }
}

