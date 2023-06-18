//
//  ViewController.swift
//  Standard_1
//
//  Created by YOUJIM on 2023/06/17.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class ViewController: UIViewController {

    @IBOutlet weak var kakaoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapKakaoBtn(_ sender: Any) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    if let openStore = URL(string: "https://www.kakaocorp.com/page/service/service/KakaoTalk"), UIApplication.shared.canOpenURL(openStore) {
                        UIApplication.shared.open(openStore, options: [:], completionHandler: nil)
                    }
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                }
            }
        }
    }
}

