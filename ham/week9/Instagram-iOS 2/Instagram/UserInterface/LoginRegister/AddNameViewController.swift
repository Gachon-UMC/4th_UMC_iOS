//
//  AddNameViewController.swift
//  Instagram
//
//  Created by 이재혁 on 2023/06/04.
//

import UIKit

class AddNameViewController: UIViewController {
    // MARK: - Properties
    var isValidName = false {
        didSet {
            self.validateButton()
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var email_to_get: String?
    var email_to_send = ""
    var name_to_send = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        nextButton.layer.cornerRadius = 4.0
        setupTextField()
        
        //이전 뷰에서 전달받은 데이터 언래핑
        if let email = email_to_get {
            email_to_send = email
        }
    }
    

    // MARK: -
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.isValidName = text.count > 0
        self.name_to_send = text
    }

    // MARK: - setup
    private func setupTextField() {
        nameTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    // 이메일주소 textfield 입력 -> '다음'버튼 활성화
    private func validateButton() {
        if isValidName {
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
        let makePasswordViewController = storyboard.instantiateViewController(withIdentifier: "MakePasswordVC") as! MakePasswordViewController
        
        // 데이터 전달
        makePasswordViewController.email_to_get = self.email_to_send
        makePasswordViewController.name_to_get = self.name_to_send
        
        // 화면전환 메서드 사용해서 화면 전환
        self.navigationController?.pushViewController(makePasswordViewController, animated: true)
    }
    
    //MARK: - return to login view
    @IBAction func returnToLoginButtonTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
