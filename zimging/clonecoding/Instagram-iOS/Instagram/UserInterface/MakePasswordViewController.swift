//
//  MakePasswordViewController.swift
//  Instagram
//
//  Created by YOUJIM on 2023/06/04.
//

import UIKit

class MakePasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var savePasswordBtn: UIButton!
    @IBOutlet weak var goToMakeNamePageBtn: UIButton!
    @IBOutlet weak var goToLoginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordField.delegate = self
        
        goToMakeNamePageBtn.isEnabled = false
        savePasswordBtn.isSelected = false
    }
    
    // 텍스트 필드의 값이 변경될 때 호출되는 메서드
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 입력된 값이 유효한지 확인하고, 각각의 입력 필드에서 값이 있을 경우 버튼을 활성화함
        let password = passwordField.text ?? ""
        goToMakeNamePageBtn.isEnabled = !password.isEmpty
    }
    
    // 비밀번호 저장 버튼 누르면 토글됨
    @IBAction func savePasswordBtnClicked(_ sender: Any) {
        // 버튼 누르면 선택 상태 반전
        savePasswordBtn.isSelected.toggle()
        // 버튼 선택 상태에 따른 체크박스 이미지 변경
        let checkbox = savePasswordBtn.isSelected ? "checkmark.square" : "checkmark.square.fill"
        savePasswordBtn.setImage(UIImage(systemName: checkbox), for: .normal)
    }
    
    // 다음 버튼 누르면 이름 만들기 화면으로 이동
    @IBAction func goToMakeNamePageBtnClicked(_ sender: Any) {
        // MARK: 화면 전환
        guard let makeNameViewController = self.storyboard?.instantiateViewController(withIdentifier: "MakeNameViewController") as? MakeNameViewController else { return }
                // 화면 전환 애니메이션 설정
                makeNameViewController.modalTransitionStyle = .coverVertical
                // 전환된 화면이 보여지는 방법 설정 (fullScreen)
                makeNameViewController.modalPresentationStyle = .fullScreen
                self.present(makeNameViewController, animated: true, completion: nil)
        
        // NotificationCenter로 비밀번호 필드에 있는 값 전달
        let confirmVC = ConfirmViewController()
            NotificationCenter.default.addObserver(confirmVC, selector: #selector(confirmVC.receivePassword(_:)), name: Notification.Name("password"), object: nil)
        
        if let password = passwordField.text {
            NotificationCenter.default.post(name: Notification.Name("password"), object: password)
        }
    }

    // 로그인 버튼 누르면 정보 저장 없이 로그인 화면으로 돌아가는 이벤트
    @IBAction func goToLoginBtnClicked(_ sender: Any) {
        if let presentVC = presentingViewController?.presentingViewController?.presentingViewController {
            dismiss(animated: true) {
                presentVC.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
