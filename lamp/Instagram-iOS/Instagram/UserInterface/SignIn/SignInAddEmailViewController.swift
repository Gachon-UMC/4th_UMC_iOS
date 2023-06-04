//
//  SignInEmailViewController.swift
//  Instagram
//
//  Created by 박민서 on 2023/05/29.
//

import UIKit

///회원가입 두번째 뷰입니다. 이메일 주소를 받습니다.
class SignInAddEmailViewController: UIViewController {
    
    @IBOutlet weak var EmailTextfield: defaultTextField!    //이메일 주소 텍스트필드는 defaultTextField class입니다. Definition 참조

    @IBOutlet weak var NextButton: UIButton!
    
    @IBOutlet weak var BottomBorderView: UIView!
    
    //좌측 상단 돌아가기 버튼 TapAction 입니다.
    @IBAction func tap_before(_ sender: Any) {
        guard let HomeVC = self.storyboard?.instantiateViewController(identifier: "SignIn_main") else {return}
        HomeVC.modalPresentationStyle = .fullScreen
        present(HomeVC, animated: true)
    }
    
    //다음 버튼 TapAction 입니다.
    @IBAction func TapNext(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "AddUsername") as? SignInAddUsernameViewController else {return}
        //다음뷰로 값을 넘겨줍니다.
        nextVC.UserEmail = EmailTextfield.text! 
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }
    
    //화면 하단 로그인 버튼 TapAction입니다.
    @IBAction func tap_login(_ sender: Any) {
        guard let HomeVC = self.storyboard?.instantiateViewController(identifier: "SignIn_main") else {return}
        HomeVC.modalPresentationStyle = .fullScreen
        present(HomeVC, animated: true)
    }
    
    ///SignInViewController와 같이 해당 VC에 NotificationObserver를 등록해줍니다.
    /// 자세한 내용은 SignInViewController 참조
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(forName: Notification.Name("CheckFields"), object: nil, queue: .main, using: {notification in
            self.CheckFieldsToEnable()
        })
        NotificationCenter.default.addObserver(forName: Notification.Name("Disable"), object: nil, queue: .main, using: {notification in
            self.NextButton.isEnabled = false
        })
    }
    
    /// 자세한 내용은 SignInViewController 참조
    func CheckFieldsToEnable() {
        if let text = EmailTextfield.text, !text.isEmpty {
            NextButton.isEnabled = true
        }
    }
    
    ///"이메일"아래 검은색 테두리를 위한 부분입니다.
    ///CALayer extension의 .addBorder는 기존 UI요소의 frame값을 갖고 오므로
    ///auto-layout 적용 후에 호출하여 바꿔줍시다.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        BottomBorderView.layer.addBorder([.bottom], color: UIColor.black, width: 1.0)
    }
    
}
