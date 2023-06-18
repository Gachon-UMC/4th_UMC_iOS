//
//  main.swift
//  Practice_2
//
//  Created by YOUJIM on 2023/06/17.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    
    private init() {}
    
    var userInfo: String?
    
    func setUserInfo(_ info: String) {
        userInfo = info
    }
    
    func getUserInfo() -> String? {
        return userInfo
    }
}

let userManager = UserManager.shared
userManager.setUserInfo("John Doe")
print(userManager.getUserInfo()!)

