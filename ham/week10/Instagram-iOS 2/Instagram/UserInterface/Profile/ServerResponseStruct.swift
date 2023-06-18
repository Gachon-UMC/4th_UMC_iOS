//
//  ServerResponseStruct.swift
//  Instagram
//
//  Created by 이재혁 on 2023/06/17.
//

import Foundation

// 프로필수정 정보 불러오기
struct ServerResponse: Decodable {
    let returnMsg: String?
    let returnCode: Int?
    let result: String?
    let isSuccess: Bool?
}

// 마이페이지 정보 불러오기
struct MyPageResponse: Codable {
    let isSuccess: Bool
    let returnCode: Int
    let returnMsg: String
    let result: Result
    
    struct Result: Codable {
        let userIdx: Int?
        let userName: String?
        let userIntro: String?
        let userWebsite: String?
        let userProfileImg: String?
        let postNum: Int?
        let followerNum: Int?
        let followingNum: Int?
        let userID: String?
    }
}

// 홈화면 게시글 리스트 정보 불러오기
struct PostListResponse: Codable {
    let isSuccess: Bool
    let returnCode: Int
    let returnMsg: String
    let result: [Result]
    
    struct Result: Codable {
        let postIdx: Int
        let userID: String
        let userProfileImg: String
        let postContent: String
        let commentNum: Int
        let uploadTime: String
        let imgList: [ImageList]
        let commentList: [CommentList]
    }
    
    struct ImageList: Codable {
        let postImgIdx: Int
        let postImgUrl: String
    }
    
    struct CommentList: Codable {
        let commentIdx: Int
        let commentContents: String
        let userID: String
    }
}
