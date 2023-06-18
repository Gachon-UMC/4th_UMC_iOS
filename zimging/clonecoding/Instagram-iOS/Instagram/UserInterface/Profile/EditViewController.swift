//
//  EditViewController.swift
//  Instagram
//
//  Created by YOUJIM on 2023/04/16.
//

import UIKit
import Alamofire

struct ModifyResponse: Codable {
    let isSuccess: Bool
    let returnCode: Int
    let returnMsg: String
    let result: String
}

protocol SendDataToProfile {
    func sendDataToP (myName: String, myID: String, myIntro: String, myLink: String)
}

class EditViewController: UIViewController, SendDataToEdit {
    func SendDataToE(myName: String, myID: String, myIntro: String, myLink: String) {
        nameText.placeholder = myName
        userNameText.placeholder = myID
        introText.placeholder = myIntro
        linkText.placeholder = myLink
    }
    
    //프로토콜로 delegate 변수 생성
    var delegate: SendDataToProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        nameText.borderStyle = .none
        introText.borderStyle = .none
        userNameText.borderStyle = .none
        linkText.borderStyle = .none
    }
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var introText: UITextField!
    @IBOutlet weak var linkText: UITextField!
    
    var name = ""
    var id = ""
    var intro = ""
    var link = ""
    var jwt = ""
    
    func setup() {
        nameText.text = name
        userNameText.text = id
        introText.text = intro
        linkText.text = link
    }
    
    @IBAction func doneBtn(_ sender: UIButton) {
        guard let tempName = nameText.text else {return}
        guard let tempId = userNameText.text else {return}
        guard let tempIntro = introText.text else {return}
        guard let tempLink = linkText.text else {return}
        
        delegate?.sendDataToP(myName: tempName, myID: tempId, myIntro: tempIntro, myLink: tempLink)

        modifyUser(userName: tempName, userId: tempId, userIntro: tempIntro, userWebsite: tempLink, jwt: jwt) { result in
            switch result {
            case .success(let modifyResponse):
                print("사용자 정보 수정 성공: \(modifyResponse.result)")
            case .failure(let error):
                print("사용자 정보 수정 실패: \(error)")
            }
        }
        
    }
}

func modifyUser(userName: String, userId: String, userIntro: String, userWebsite: String, jwt: String, completion: @escaping (Result<ModifyResponse, Error>) -> Void) {
    let parameters: [String: Any] = [
        "userName" : userName,
        "userId" : userId,
        "userIntro" : userIntro,
        "userWebsite" : userWebsite
    ]
    
    let headers: HTTPHeaders = ["X-ACCESS-TOKEN": jwt]
    
    AF.request(APIConstants.modifyURL, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .responseDecodable(of: ModifyResponse.self) { response in
            switch response.result {
            case .success(let modifyResponse):
                completion(.success(modifyResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
}
