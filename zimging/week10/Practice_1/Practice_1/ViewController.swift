//
//  ViewController.swift
//  Practice_1
//
//  Created by YOUJIM on 2023/06/17.
//

import UIKit

class UserManager {
    var userInfo: String?
    
    func getUserInfo(completion: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.userInfo = "John Doe"
            completion(self.userInfo ?? "")
        }
    }
}

class ViewController: UIViewController {
    let userManager = UserManager()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            getUserInformation { userInfo in
                print("사용자 정보: \(userInfo)")
            }
        }
        
        func getUserInformation(completion: @escaping (String) -> Void) {
            userManager.getUserInfo { userInfo in
                completion(userInfo)
            }
        }
}

