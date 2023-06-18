//
//  KakaoLoginViewController.swift
//  ExpertWorkBook
//
//  Created by 박민서 on 2023/06/13.
//

import Foundation
import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import Kingfisher

class KakaoLoginViewController: UIViewController {
    
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserNickname: UILabel!
    
    @IBAction func LogInButton(_ sender: Any) {
        SingletonForKakao.shared.kakaoTokenCheck { Result in
            switch Result {
            case .go_login:
                SingletonForKakao.shared.kakao_Login_onWeb { Result in
                    switch Result {
                    case .success :
                        SingletonForKakao.shared.kakao_getUserInfo(self.setUserDatatoUI)
                    case .Error(let error) :
                        print(error.localizedDescription)
                    default :
                        print()
                    }
                }
            case .already_loggedin:
                print("이미 로그인 되어 있습니다.")
            case .Error(let error):
                print(error.localizedDescription)
            default :
                print()
            }
        }
        
//        if (AuthApi.hasToken()) {
//            UserApi.shared.accessTokenInfo { (_, error) in
//                if let error = error {
//                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
//                        //로그인 필요
//                        self.kakao_Login_onWeb()
//                    }
//                    else {
//                        //기타 에러
//                        print(error.localizedDescription)
//                    }
//                }
//                else {
//                    print("이미 로그인되었습니다.")
//                }
//            }
//        }
//        else {
//            //로그인 필요
//            self.kakao_Login_onWeb()
//
//        }
    }
    
    @IBAction func LogOutButton(_ sender: Any) {
        SingletonForKakao.shared.kakaoLogout {
            self.UserImage.image = UIImage()
            self.UserNickname.text = "로그인되지 않았습니다."
        }
//        self.kakaoLogout() {
//            DispatchQueue.main.async {
//                self.UserImage.image = UIImage()
//                self.UserNickname.text = "로그인되지 않았습니다."
//            }
//        }
    }
    
    @IBAction func SeeLogButton(_ sender: Any) {
        let logs = SingletonForKakao.shared.realm.objects(TLog.self)
        print(logs)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(SingletonForKakao.shared.UserInfo)
        SingletonForKakao.shared.kakaoTokenCheck { Result in
            switch Result {
            case .go_login :
                SingletonForKakao.shared.kakao_Login_onWeb { Result in
                    switch Result {
                    case .success :
                        SingletonForKakao.shared.kakao_getUserInfo(self.setUserDatatoUI)
                    case .Error(let error) :
                        print(error.localizedDescription)
                    default :
                        print()
                    }
                }
            case .already_loggedin :
                SingletonForKakao.shared.kakao_getUserInfo(self.setUserDatatoUI)
            case .Error(let error) :
                print(error.localizedDescription)
            default :
                print()
            }
            
        }
    }
    
    func setUserDatatoUI() {
        let UserImageURL = SingletonForKakao.shared.UserInfo["UserImage"]
        let UserNickname = SingletonForKakao.shared.UserInfo["UserNickname"]
        self.UserImage.kf.setImage(with: URL(string: UserImageURL!))
        self.UserNickname.text = UserNickname
    }
    
    
    

    

}

//    func kakao_test_onApp() {
//        // 카카오톡 실행 가능 여부 확인
//        if (UserApi.isKakaoTalkLoginAvailable()) {
//            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                if let error = error {
//                    print(error)
//                }
//                else {
//                    print("loginWithKakaoTalk() success.")
//
//                    //do something
//                    _ = oauthToken
//                }
//            }
//        }
//    }
