//
//  ConfirmViewController.swift
//  Instagram
//
//  Created by YOUJIM on 2023/06/04.
//

import UIKit

class ConfirmViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel?
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var goToLoginBtn: UIButton!
    
    var userInfo = UserInfo(name: "", username: "", email: "", password: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(userInfo)
    }
    
    // Notification 수신 후 데이터 처리를 위한 메서드
    @objc func receiveName(_ notification: Notification) {
        if let data = notification.object as? String {
            print(data)
            userInfo.name = data
            print(userInfo.name)
            
            // userNameLabel.text = "\(userInfo.name)님으로"
        }
    }
    
    // Notification 수신 후 데이터 처리를 위한 메서드
    @objc func receiveUserName(_ notification: Notification) {
        if let data = notification.object as? String {
            userInfo.username = data
        }
    }
    
    // Notification 수신 후 데이터 처리를 위한 메서드
    @objc func receiveEmail(_ notification: Notification) {
        if let data = notification.object as? String {
            userInfo.email = data
        }
    }
    
    // Notification 수신 후 데이터 처리를 위한 메서드
    @objc func receivePassword(_ notification: Notification) {
        if let data = notification.object as? String {
            userInfo.password = data
        }
    }
    
    // TODO: userdefault 사용해서 사용자 이름과 비밀번호 로컬에 저장
    @IBAction func signUpBtnClicked(_ sender: Any) {
        print(userInfo)
    }
    
    // 로그인 버튼 누르면 정보 저장 없이 로그인 화면으로 돌아가는 이벤트
    @IBAction func goToLoginBtnClicked(_ sender: Any) {
        // MARK: 화면 전환
        if let presentVC = presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController {
            dismiss(animated: true) {
                presentVC.dismiss(animated: true, completion: nil)
            }
        }
    }

}
