//
//  LoginViewController.swift
//  Instagram
//
//  Created by 이재혁 on 2023/06/04.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - properties
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet weak var PWTextField: UITextField!
    @IBOutlet weak var loginFailLabel: UILabel!
    
    @IBOutlet weak var XButtonInID: UIButton!
    @IBOutlet weak var toggleButtonInPW: UIButton!
    
    var isValidID = false {
        didSet {
            self.validateButton() // 버튼 활성화
            // x 버튼 보일지, 말지
            if isValidID {self.XButtonInID.layer.isHidden = false}
            else {self.XButtonInID.layer.isHidden = true}
        }
    }
    var isValidPW = false {
        didSet {
            self.validateButton()
        }
    }
    
    var id = String()
    var password = String()
    
    var textFields: [UITextField] {
        [IDTextField, PWTextField]
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.IDTextField.delegate = self
        XButtonInID.layer.isHidden = true
        setupTextField()
        PWTextField.isSecureTextEntry = true //비밀번호 raw 표시 안되게
        loginFailLabel.isHidden = true
        loginButton.layer.cornerRadius = 4.0
    }
    
    
    @IBAction func clearButtonClicked(_ sender: UIButton) {
        IDTextField.text = ""
        isValidID = false
    }
    
    
    
    // visible/invisible 버튼
    @IBAction func toggleButtonClicked(_ sender: UIButton) {
        PWTextField.isSecureTextEntry.toggle()
        
        let buttonImageName = PWTextField.isSecureTextEntry ? "Invisible" : "Visible"
        let buttonImage = UIImage(named: buttonImageName)
        toggleButtonInPW.setImage(buttonImage, for: .normal)
    }
    
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        switch sender {
        case IDTextField:
            self.isValidID = text.count > 0
            self.id = text
            IDTextField.layer.borderWidth = 0
            
        case PWTextField:
            self.isValidPW = text.count > 0
            self.password = text
            PWTextField.layer.borderWidth = 0
            //self.XButtonInID.layer.isHidden = true
        default:
            fatalError("Missing TextField..")
        }
    }
    
    private func setupTextField() {
        textFields.forEach { TF in
            TF.addTarget(self, action: #selector(textFieldEditingChanged(_:)),
                         for: .editingChanged)
        }
    }
    
    private func validateButton() {
        if isValidID && isValidPW {
            self.loginButton.isEnabled = true
            self.loginButton.backgroundColor = UIColor.link
            self.loginButton.layer.cornerRadius = 4.0
        } else {
            self.loginButton.isEnabled = false
            self.loginButton.backgroundColor = .buttonDisabledColor
            self.loginButton.layer.cornerRadius = 4.0
        }
    }
    
    
    //MARK: - 로그인
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        let savedID = defaults.string(forKey: "userName")
        let savedPassword = defaults.string(forKey: "userPassword")
        
        if self.password == savedPassword && self.id == savedID {
            //로그인 성공
            //마이페이지 이동
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
            
            // 화면전환 -> 마이페이지
            tabBarController.selectedIndex = 4
            UIApplication.shared.keyWindow?.rootViewController = tabBarController
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
            
            print("로그인 성공")
            
            
            
            
        } else {
            print("로그인 실패")
            
            if self.id != savedID {
                // IDTextField 테두리 빨갛게
                self.IDTextField.layer.borderWidth = 1.0
                self.IDTextField.layer.borderColor = UIColor.systemPink.cgColor
                self.IDTextField.layer.cornerRadius = 4.0
                
                // 아이디 오류 label 표시
                loginFailLabel.text = "사용자 이름 오류."
                loginFailLabel.textColor = .systemPink
                loginFailLabel.isHidden = false
            }
            else if self.password != savedPassword {
                self.PWTextField.layer.borderWidth = 1.0
                self.PWTextField.layer.borderColor = UIColor.systemPink.cgColor
                self.PWTextField.layer.cornerRadius = 4.0
                
                // 비밀번호 오류 label 표시
                loginFailLabel.text = "비밀번호 오류."
                loginFailLabel.textColor = .systemPink
                loginFailLabel.isHidden = false
            }
        }
    }
    
    
    
    
    
    //MARK: - 회원가입
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        // 회원가입 버튼 누르면 화면전환
        // 스토리보드 생성
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 뷰컨트롤러 생성
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        
        // 화면전환 메서드 사용해서 화면 전환
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    
    //MARK: - 커서 포커싱 -> X 버튼
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.XButtonInID.layer.isHidden = true // 커서 포커스 잃으면 가려짐
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !isValidID {
            self.XButtonInID.layer.isHidden = true // ID 빈칸일 때 가려짐
        } else {
            self.XButtonInID.layer.isHidden = false // 커서 포커스 다시 찾으면 표시됨
        }
        
    }
}


//MARK: - custom color
extension UIColor {
    class var buttonDisabledColor: UIColor? {
        return UIColor(named: "buttonDisabledColor")
    }
}
