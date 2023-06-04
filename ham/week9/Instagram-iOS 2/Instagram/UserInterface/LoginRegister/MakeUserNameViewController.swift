//
//  MakeUserNameViewController.swift
//  Instagram
//
//  Created by 이재혁 on 2023/06/04.
//

import UIKit

class MakeUserNameViewController: UIViewController {
    //MARK: - Properties
    var isValidUserName = false {
        didSet {
            validateButton()
        }
    }
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var email_to_get: String?
    var name_to_get: String?
    var password_get: String?
    
    var email_to_send = ""
    var name_to_send = ""
    var password_to_send: String = ""
    var userName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        nextButton.layer.cornerRadius = 4.0
        setupTextField()
        
        //이전 뷰에서 전달받은 데이터 언래핑
        if let email = email_to_get {
            self.email_to_send = email
        }
        if let name = name_to_get {
            self.name_to_send = name
        }
        if let password = password_get {
            self.password_to_send = password
        }
    }
    
    // MARK: -
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.isValidUserName = text.count > 0
        self.userName = text
    }

    // MARK: - setup
    private func setupTextField() {
        userNameTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    // 이메일주소 textfield 입력 -> '다음'버튼 활성화
    private func validateButton() {
        if isValidUserName {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = UIColor.link
        } else {
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = UIColor.buttonDisabledColor
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // 다음 버튼 누르면 화면전환
        // 스토리보드 생성
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 뷰컨트롤러 생성
        let finalRegisterViewController = storyboard.instantiateViewController(withIdentifier: "RegisterFinalVC") as! RegisterFinalViewController
        
        // 데이터 전달
        finalRegisterViewController.email_to_get = self.email_to_send
        finalRegisterViewController.name_to_get = self.name_to_send
        finalRegisterViewController.password_to_get = self.password_to_send
        finalRegisterViewController.userName_to_get = self.userName
        
        // 화면 전환
        self.navigationController?.pushViewController(finalRegisterViewController, animated: true)
    }
    
    //MARK: - return to login view
    @IBAction func returnToLoginButtonTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    

}
