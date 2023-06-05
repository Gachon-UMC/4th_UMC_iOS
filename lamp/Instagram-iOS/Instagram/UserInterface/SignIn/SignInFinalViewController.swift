//
//  SignInFinalViewController.swift
//  Instagram
//
//  Created by 박민서 on 2023/05/29.
//

import UIKit

///회원가입 마지막 뷰입니다. 가입시 정보를 출력, UserDefaults에 저장합니다.
class SignInFinalViewController: UIViewController {
    var UserEmail: String = "" //직전 뷰에서 가져온 Email값입니다.
    var UserPassword: String = "" //직전 뷰에서 가져온 비밀번호값입니다.
    var UserName: String = "" //직전 뷰에서 가져온 이름값입니다.
    var UserID: String = "" //직전 뷰에서 가져온 사용자 이름(ID)값입니다.
    
    @IBOutlet weak var UserNameLabel: UILabel!
    
    //화면 하단 로그인 버튼 TapAction입니다.
    @IBAction func tap_login(_ sender: Any) {
        guard let HomeVC = self.storyboard?.instantiateViewController(identifier: "SignIn_main") else {return}
        HomeVC.modalPresentationStyle = .fullScreen
        present(HomeVC, animated: true)
    }
    
    //가입하기 버튼 TapAction입니다.
    @IBAction func tap_SignIn(_ sender: Any) {
        print("이메일 : \(UserEmail)")
        print("이름 : \(UserName)")
        print("비밀번호 : \(UserPassword)")
        print("사용자 이름 : \(UserID)")
        
        let IDPW: [String] = [UserID,UserPassword]
        UserDefaults.standard.set(IDPW, forKey: "IDPW")
        
        //메인화면으로 돌아갑니다.
        guard let HomeVC = self.storyboard?.instantiateViewController(identifier: "SignIn_main") else {return}
        HomeVC.modalPresentationStyle = .fullScreen
        present(HomeVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        UserNameLabel.text = "\(UserID)님으로 가입하시겠어요?" //가입 과정에서 입력한 사용자이름(ID)값으로 text를 수정합니다.
    }
}
