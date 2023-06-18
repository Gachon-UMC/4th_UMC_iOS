//
//  MakePasswordViewController.swift
//  Instagram
//
//  Created by 이재혁 on 2023/06/04.
//

import UIKit

class MakePasswordViewController: UIViewController {
    // MARK: - Properties
    var isValidPassword = false {
        didSet {
            validateButton()
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var email_to_get : String?
    var name_to_get: String?
    var email_to_send = ""
    var name_to_send = ""
    var password = ""
    
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
    }
    
    // MARK: -
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.isValidPassword = text.count > 0
        self.password = text
    }

    // MARK: - setup
    private func setupTextField() {
        passwordTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    // 이메일주소 textfield 입력 -> '다음'버튼 활성화
    private func validateButton() {
        if isValidPassword {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = UIColor.link
        } else {
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = UIColor.buttonDisabledColor
        }
    }
    
    //MARK: - next view
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // 다음 버튼 누르면 화면전환
        // 스토리보드 생성
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 뷰컨트롤러 생성
        let makeUserNameViewController = storyboard.instantiateViewController(withIdentifier: "MakeUserNameVC") as! MakeUserNameViewController
        
        // 데이터 전달
        makeUserNameViewController.password_get = self.password
        makeUserNameViewController.email_to_get = self.email_to_send
        makeUserNameViewController.name_to_get = self.name_to_send
        
        // 화면전환 메서드 사용해서 화면 전환
        self.navigationController?.pushViewController(makeUserNameViewController, animated: true)
    }
    

    //MARK: - return to login view
    @IBAction func returnToLoginButtonTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}
