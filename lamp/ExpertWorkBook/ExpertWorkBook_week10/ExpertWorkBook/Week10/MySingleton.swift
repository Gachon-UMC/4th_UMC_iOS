//
//  MySingleton.swift
//  ExpertWorkBook
//
//  Created by 박민서 on 2023/06/16.
//

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import RealmSwift

class SingletonForKakao {
    static let shared = SingletonForKakao()
    private init() {}
    let realm = try! Realm()
    
    enum Result {
        case success
        case go_login
        case already_loggedin
        case Error(Error)
    }
    
    var UserInfo: [String : String] = ["UserImage":"","UserNickname":""]
    
    func kakaoTokenCheck(_ completion: @escaping (Result) -> Void) {
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true {
                        //로그인 필요
                        completion(Result.go_login)
                    }
                    else {
                        //에러호출
                        completion(Result.Error(error))
                    }
                }
                else {
                    //토큰 인증 성공 - 로그인 되어있는거
                    completion(Result.already_loggedin)
                }
            }
        }
        else {
            //로그인 필요
            completion(Result.go_login)
        }
    }
    
    
    func kakao_Login_onWeb(_ completion: @escaping (Result) -> Void) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
                completion(Result.Error(error))
            }
            else {
                print("loginWithKakaoAccount() success.")
                completion(Result.success)
            }
        }
    }
    
    func kakao_getUserInfo(_ completion: @escaping () -> Void) {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                self.UserInfo["UserImage"] = user?.properties?["profile_image"]
                self.UserInfo["UserNickname"] = user?.properties?["nickname"]
                print("Got UserInfo Safely")
                
                UserApi.shared.accessTokenInfo { (AccessTokenInfo, Error) in
                    
                    let Log = TLog(name: (user?.properties?["nickname"])!, status: "Log-In", time: (user?.connectedAt)!, accessToken: String((AccessTokenInfo?.id)!))
                    try! self.realm.write {
                        self.realm.add(Log)
                    }
                }
                completion()
            }
        }
    }
    
    func kakaoLogout(_ completion: @escaping () -> Void) {
        
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                let Log = TLog(name: self.UserInfo["UserNickname"]!, status: "Log-Out", time: Date(), accessToken: "")
                try! self.realm.write {
                    self.realm.add(Log)
                }
                self.UserInfo["UserImage"] = ""
                self.UserInfo["UserNickname"] = ""
                print("logout() success.")
                completion()
            }
        }
    }
    
}


/*
 enum APIResult<T, Error> {
     case success(T)
     case failure(Error)
 }

 func fetchData(completion: @escaping (APIResult<String, Error>) -> Void) {
     // 비동기 작업을 수행하고 결과를 받아옴
     let successResult: String = "Data fetched successfully"
     let failureResult: Error = NSError(domain: "example", code: 0, userInfo: nil)
     
     // 비동기 작업이 완료되면, 결과에 따라 적절한 Enum case를 생성하여 클로저를 호출
     if success {
         completion(.success(successResult))
     } else {
         completion(.failure(failureResult))
     }
 }

 fetchData { result in
     switch result {
     case .success(let data):
         print("Data: \(data)")
     case .failure(let error):
         print("Error: \(error)")
     }
 }
 */
