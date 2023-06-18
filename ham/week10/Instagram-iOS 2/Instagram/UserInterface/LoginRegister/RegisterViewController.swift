//
//  RegisterViewController.swift
//  Instagram
//
//  Created by 이재혁 on 2023/06/04.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: - 변수
    var isValidEmail = false {
        didSet {
            self.validateButton()
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var email_to_send = ""
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "" //backbutton만 나오게
        self.navigationController?.navigationBar.tintColor = .black //backbutton 색깔 까맣게
        self.navigationController?.navigationBar.isHidden = false
        setupTextField()
        nextButton.layer.cornerRadius = 4.0
        // Do any additional setup after loading the view.
    }
    

    // MARK: -
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.isValidEmail = text.count > 0
        self.email_to_send = text
    }
    
    // MARK: - setup
    private func setupTextField() {
        emailTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    // 이메일주소 textfield 입력 -> '다음'버튼 활성화
    private func validateButton() {
        if isValidEmail {
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
        let addNameViewController = storyboard.instantiateViewController(withIdentifier: "AddNameVC") as! AddNameViewController
        
        // email 데이터 전달
        addNameViewController.email_to_get = self.email_to_send
        
        // 화면전환 메서드 사용해서 화면 전환
        self.navigationController?.pushViewController(addNameViewController, animated: true)
    }
    
    //MARK: - return to login view
    @IBAction func returnToLoginButtonTapped(_ sender: UIButton) {

        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}
