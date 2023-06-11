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
    
    var emailToSend : String?
    var nameToSend : String?
    var passwordToSend: String?
    var userNameToSend: String?
    
    // UserDefault를 위한 encoder 변수 선언
    let encoder = JSONEncoder()
    
    var userInfo = UserInfo(name: "", username: "", email: "", password: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 받아온 값 userInfo에 저장
        userInfo.email = emailToSend!
        userInfo.name = nameToSend!
        userInfo.password = passwordToSend!
        userInfo.username = userNameToSend!
        
        userNameLabel?.text = "\(userInfo.username)님으로"
    }
    
   
    @IBAction func signUpBtnClicked(_ sender: Any) {
        // MARK: userdefault 사용해서 사용자 이름과 비밀번호 로컬에 저장
        if let encoded = try? encoder.encode(userInfo) {
            UserDefaults.standard.set(encoded, forKey: "userInfo")
        }
        
        // Print문으로 이메일, 이름, 비밀번호, 사용자 이름 출력
        print("\(userInfo.email) \(userInfo.name) \(userInfo.password) \(userInfo.username)")
        
        // 화면 전환
        guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        
        // 화면 전환 애니메이션 설정
        loginVC.modalTransitionStyle = .coverVertical
        // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        loginVC.modalPresentationStyle = .fullScreen
        
        self.present(loginVC, animated: true, completion: nil)
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
