//
//  LoginViewController.swift
//  Instagram
//
//  Created by YOUJIM on 2023/06/03.
//

import UIKit
import Alamofire

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let isSuccess: Bool
    let returnCode: Int
    let returnMsg: String
    let result: ResultValue
}

// MARK: - Result
struct ResultValue: Codable {
    let userIdx: Int
    let jwt: String
}

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var forgetPassword: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    // passwordField 오른쪽에 있는 눈 버튼
    let visibleBtn = UIButton()
    
    let decoder = JSONDecoder()
    
    // 로그인 성공했는지 여부를 담을 객체와 마이페이지에 넘길 jwt 선언
    var returnCode = -1
    var jwt = ""
    
    // 유저 정보 담을 객체 선언
    var userInfo = UserInfo(name: "", username: "", email: "", password: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordField.delegate = self
        idField.delegate = self
        
        // 입력 필드 모서리 둥글게
        passwordField.layer.cornerRadius = 10.0
        idField.layer.cornerRadius = 10.0
        
        // passwordField 오른쪽에 눈 버튼 추가
        let eyeImage = UIImage(named: "Invisible")
        visibleBtn.setBackgroundImage(eyeImage, for: .normal)
        visibleBtn.frame = CGRectMake(0, 0, 36, 36)
        
        passwordField.isSecureTextEntry = true
        passwordField.rightView = visibleBtn
        passwordField.rightViewMode = UITextField.ViewMode.always
        
        // 눈 버튼 이벤트 추가
        visibleBtn.addTarget(self, action: #selector(eyeClick), for: .touchUpInside)
        
        // idField의 x 버튼은 텍스트가 있을 때 & 사용자가 수정중일 때만 보이도록
        idField.clearButtonMode = .whileEditing
        
        // 로그인 버튼 활성화 상태 초기에는 false
        loginBtn.isEnabled = false
        
        // 저장된 유저 정보 decode해서 불러오기
        if let user = UserDefaults.standard.object(forKey: "userInfo") as? Data {
            if let savedObject = try? decoder.decode(UserInfo.self, from: user) {
                userInfo = savedObject
            }
        }
    }
    
    // 텍스트 필드의 값이 변경될 때 호출되는 메서드
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 입력된 값이 유효한지 확인하고, 각각의 입력 필드에서 값이 있을 경우 로그인 버튼을 활성화함
        let id = idField.text ?? ""
        let password = passwordField.text ?? ""
        
        let isButtonEnabled = !id.isEmpty && !password.isEmpty
        loginBtn.isEnabled = isButtonEnabled
    }
    
    // 로그인 버튼이 눌리면 호출되는 메서드
    @IBAction func loginBtnClicked(_ sender: Any) {
        let id = idField.text ?? ""
        let password = passwordField.text ?? ""
        
        loginUser(userInfo: id, userPwd: password) {result in
            switch result {
            case .success(let loginResponse):
                // 로그인 성공할 경우 성공 print해주고 response 값 변수에 저장
                print("로그인 성공: \(loginResponse)")
                self.returnCode = loginResponse.returnCode
                print("User Index: \(loginResponse.result.userIdx)")
                print("JWT: \(loginResponse.result.jwt)")
                self.jwt = loginResponse.result.jwt
                // 아이디와 비밀번호가 둘다 일치할 경우
                if self.returnCode == 1000 {
                    // 마이페이지로 이동
                    guard let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
                    
                    // 화면 전환 애니메이션 설정
                    tabVC.modalTransitionStyle = .coverVertical
                    // 전환된 화면이 보여지는 방법 설정 (fullScreen)
                    tabVC.modalPresentationStyle = .fullScreen
                    
                    // jwt 값 userDefault에 넣어서 저장
                    UserDefaults.standard.set(self.jwt, forKey: "jwt")
                    
                    
                    self.present(tabVC, animated: true, completion: nil)
                }
                // 아이디가 다를 경우
                else if self.returnCode == 2013 {
                    self.idField.layer.borderWidth = 1.0
                    self.idField.layer.borderColor = UIColor.red.cgColor
                    self.errorLabel.textColor = UIColor.red
                    self.errorLabel.text = "사용자 이름 오류."
                }
                // 아이디는 같은데 비밀번호가 다를 경우
                else if self.returnCode == 3014 {
                    self.passwordField.layer.borderWidth = 1.0
                    self.passwordField.layer.borderColor = UIColor.red.cgColor
                    self.errorLabel.textColor = UIColor.red
                    self.errorLabel.text = "비밀번호 오류."
                }
            case .failure(let error):
                print("로그인 실패: \(error)")
            }
        }
    }
    
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        guard let emailViewController = self.storyboard?.instantiateViewController(withIdentifier: "EmailViewController") as? EmailViewController else { return }
        // 화면 전환 애니메이션 설정
        emailViewController.modalTransitionStyle = .coverVertical
        // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        emailViewController.modalPresentationStyle = .fullScreen
        self.present(emailViewController, animated: true, completion: nil)
    }
    
    @objc func eyeClick() {
        // 보안 설정 반전
        passwordField.isSecureTextEntry.toggle()
        // 버튼 선택 상태 반전
        visibleBtn.isSelected.toggle()
        // 버튼 선택 상태에 따른 눈 모양 이미지 변경
        let eyeImage = visibleBtn.isSelected ? "visible" : "Invisible"
        visibleBtn.setImage(UIImage(named: eyeImage), for: .normal)
        // 버튼 선택된 경우 틴트 컬러 투명으로
        visibleBtn.tintColor = .clear
        
    }
}

func loginUser(userInfo: String, userPwd: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
    let parameters: [String: Any] = [
        "userInfo" : userInfo,
        "userPwd" : userPwd
    ]
    
    AF.request(APIConstants.loginURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let loginResponse):
                completion(.success(loginResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
}


