//
//  ResponseStruct.swift
//  Instagram
//
//  Created by 이재혁 on 2023/06/16.
//

import Foundation

// 로그인 시 Response로 받을 것..
struct Response: Codable {
    let returnMsg: String
    let isSuccess: Bool
    let result: Result
    let returnCode: Int
    
    struct Result: Codable {
        let jwt: String
        let userIdx: Int
    }
}
