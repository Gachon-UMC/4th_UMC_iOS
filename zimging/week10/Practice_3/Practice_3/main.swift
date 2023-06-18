//
//  main.swift
//  Practice_3
//
//  Created by YOUJIM on 2023/06/17.
//

import Foundation
import Valet

class TokenManager {
    static let shared = TokenManager()
    
    private let valet = Valet.valet(with: Identifier(nonEmpty: "com.example.app")!, accessibility: .whenUnlocked)
    private let tokenKey = "AuthToken"
    
    private init() {}
    
    func saveToken(_ token: String) {
        do {
            try valet.setString(token, forKey: tokenKey)
        } catch {
            print("Error saving token: \(error)")
        }
    }
    
    func retrieveToken() -> String? {
        do {
            return try valet.string(forKey: tokenKey)
        } catch {
            print("Error retrieving token: \(error)")
            return nil
        }
    }
    
    func deleteToken() {
        do {
            try valet.removeObject(forKey: tokenKey)
        } catch {
            print("Error deleting token: \(error)")
        }
    }
}

let tokenManager = TokenManager.shared
tokenManager.saveToken("my-token")
if let token = tokenManager.retrieveToken() {
    print("Retrieved token: \(token)")
}
tokenManager.deleteToken()
let deletedToken = tokenManager.retrieveToken()
print("Deleted token: \(deletedToken)")

