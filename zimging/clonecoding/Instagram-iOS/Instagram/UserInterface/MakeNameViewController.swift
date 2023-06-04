//
//  MakeNameViewController.swift
//  Instagram
//
//  Created by YOUJIM on 2023/06/04.
//

import UIKit

class MakeNameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var goToConfirmPageBtn: UIButton!
    @IBOutlet weak var goToLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameField.delegate = self
        goToConfirmPageBtn.isEnabled = false
    }
    
    // 텍스트 필드의 값이 변경될 때 호출되는 메서드
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 입력된 값이 유효한지 확인하고, 각각의 입력 필드에서 값이 있을 경우 버튼을 활성화함
        let name = userNameField.text ?? ""
        goToConfirmPageBtn.isEnabled = !name.isEmpty
    }
    
    // 다음 버튼 누르면 확인 화면으로 이동
    @IBAction func goToMakeNamePageBtnClicked(_ sender: Any) {
        // MARK: 화면 전환
        guard let confirmViewController = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmViewController") as? ConfirmViewController else { return }
        // 화면 전환 애니메이션 설정
        confirmViewController.modalTransitionStyle = .coverVertical
        // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        confirmViewController.modalPresentationStyle = .fullScreen
        self.present(confirmViewController, animated: true, completion: nil)
        
        // NotificationCenter로 이메일 필드에 있는 값 전달
        let confirmVC = ConfirmViewController()
        NotificationCenter.default.addObserver(confirmVC, selector: #selector(confirmVC.receiveUserName(_:)), name: Notification.Name("username"), object: nil)
        
        if let username = userNameField.text {
            NotificationCenter.default.post(name: Notification.Name("username"), object: username)
        }
        
    }

    

    // 로그인 버튼 누르면 정보 저장 없이 로그인 화면으로 돌아가는 이벤트
    @IBAction func goToLoginBtnClicked(_ sender: Any) {
        if let presentVC = presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController {
            dismiss(animated: true) {
                presentVC.dismiss(animated: true, completion: nil)
            }
        }
    }

}
