//
//  RegisterFinalViewController.swift
//  Instagram
//
//  Created by 이재혁 on 2023/06/04.
//

import UIKit

class RegisterFinalViewController: UIViewController {

    //MARK: - Properties
    var email_to_get: String?
    var name_to_get: String?
    var password_to_get: String?
    var userName_to_get: String?
    
    var email_to_save = ""
    var name_to_save = ""
    var password_to_save = ""
    var userName_to_save = ""
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 이전 뷰에서 전달받은 데이터 언래핑
        // 1. userEmail
        if let email = email_to_get {
            self.email_to_save = email
        }
        // 2. userName
        if let name = name_to_get {
            self.name_to_save = name
        }
        // 3. userPwd
        if let password = password_to_get {
            self.password_to_save = password
        }
        // 4. userId
        if let userName = userName_to_get {
            self.userName_to_save = userName
        }
        
        //head text
        userNameLabel.text = "\(userName_to_save)님으로\n가입하시겠어요?"
        userNameLabel.numberOfLines = 0
    }
    
    //MARK: - 가입하기 버튼 액션
    @IBAction func finalRegisterButtonTapped(_ sender: UIButton) {
        /*
         230616 api 연동을 위해 주석처리
        
         // UserDefaults로 userName과 password 저장
        let defaults = UserDefaults.standard
        defaults.set(self.userName_to_save, forKey: "userName")
        defaults.set(self.password_to_save, forKey: "userPassword")
        
        // print문으로 이메일, 이름, 비밀번호, 사용자 이름 출력
        print("이메일: \(email_to_save)")
        print("이름: \(name_to_save)")
        print("비밀번호: \(password_to_save)")
        print("사용자 이름: \(userName_to_save)")
        
        // 로그인 화면으로 돌아감
        navigationController?.popToRootViewController(animated: true)
         
         */
        
        
        //MARK: -- 회원가입 API 연결
        /* 회원가입 api 연동 */
        
        // URL 생성
        guard let url = URL(string: "https://umc.ljhhosting.com/api/user/join") else {return}
        
        // URLRequest 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // HTTP Headers 설정
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // HTTP Body 설정
        let json: [String: Any] = ["userName": self.name_to_save,
                                   "userId": self.userName_to_save,
                                   "userEmail": self.email_to_save,
                                   "userPwd": self.password_to_save]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        
        // URLSession -> 네트워크 요청
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                //에러 처리
                print("Error: \(error)")
            } else if let data = data {
                do {
                    // 응답 처리
                    if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Success: \(response)")
                        
                        // 로그인 VC 이동
                        DispatchQueue.main.async {
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    }
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    
    

    //MARK: - return to login view
    @IBAction func returnToLoginButtonTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    

}
