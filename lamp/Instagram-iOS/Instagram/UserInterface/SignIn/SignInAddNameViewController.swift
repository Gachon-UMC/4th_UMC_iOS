//
//  SignInAddNameViewController.swift
//  Instagram
//
//  Created by 박민서 on 2023/05/29.
//

import UIKit

///회원가입 세번째 뷰입니다. 이름을 받습니다. ->. !주의사항 : 이름은 사용자이름(ID)와 다릅니다. ID값은 뒤의 뷰에서 입력받습니다.
class SignInAddUsernameViewController: UIViewController {
    
    @IBOutlet weak var UsernameTextField: defaultTextField!  //이름 텍스트필드는 defaultTextField class입니다. Definition 참조
    @IBOutlet weak var NextButton: UIButton!
    
    var UserEmail: String = ""  //직전 뷰에서 가져온 Email값입니다.
    
    //화면 하단 로그인 버튼 TapAction입니다.
    @IBAction func tap_login(_ sender: Any) {
        guard let HomeVC = self.storyboard?.instantiateViewController(identifier: "SignIn_main") else {return}
        HomeVC.modalPresentationStyle = .fullScreen
        present(HomeVC, animated: true)
    }
    
    //다음 버튼 TapAction 입니다.
    @IBAction func TapNext(_ sender: Any) {
        guard let NextVC = self.storyboard?.instantiateViewController(identifier: "AddPW") as? SignInAddPasswordViewController else {return}
        //다음뷰로 값을 넘겨줍니다.
        NextVC.UserEmail = self.UserEmail
        NextVC.UserName = self.UsernameTextField.text!
        NextVC.modalPresentationStyle = .fullScreen
        present(NextVC, animated: true)
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
        if let text = UsernameTextField.text, !text.isEmpty {
            NextButton.isEnabled = true
        }
    }
}
