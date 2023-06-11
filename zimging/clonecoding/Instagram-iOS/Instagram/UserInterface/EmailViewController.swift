//
//  EmailViewController.swift
//  Instagram
//
//  Created by YOUJIM on 2023/06/04.
//

import UIKit



class EmailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backToLoginBtn: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var goToNamePageBtn: UIButton!
    @IBOutlet weak var goToLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self

        // 다음 버튼 활성화 상태 초기에는 false
        goToNamePageBtn.isEnabled = false
    }
    
    // 텍스트 필드의 값이 변경될 때 호출되는 메서드
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 입력된 값이 유효한지 확인하고, 각각의 입력 필드에서 값이 있을 경우 버튼을 활성화함
        let email = emailField.text ?? ""
        goToNamePageBtn.isEnabled = !email.isEmpty
    }
    
    // 다음 버튼 눌렀을 때 화면 전환 이벤트
    @IBAction func NamePageBtnClicked(_ sender: Any) {
        
        guard let nameVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNameViewController") as? AddNameViewController else { return }
        
        // 화면 전환 애니메이션 설정
        nameVC.modalTransitionStyle = .coverVertical
        // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        nameVC.modalPresentationStyle = .fullScreen
        
        // AddNameViewController로 emailField의 값 넘겨줌
        if let email = emailField.text {
            nameVC.emailToSend = email
        }
        
        self.present(nameVC, animated: true, completion: nil)
    }
    
    // 이메일 주소 입력 위 버튼 눌렀을 때 다시 돌아감
    @IBAction func BackToLoginBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // 화면 하단 로그인 버튼 눌렀을 때 로그인 화면으로 돌아감
    @IBAction func GoToLoginBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
