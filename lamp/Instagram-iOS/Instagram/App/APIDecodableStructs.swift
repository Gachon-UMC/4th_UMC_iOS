//
//  APIDecodableStructs.swift
//  Instagram
//
//  Created by 박민서 on 2023/06/17.
//

//APIManger를 위한 Decodable Struct들을 작성한 파일입니다.

/// POST_SignIn 함수에 필요한 Struct
/// SignLogIn_result를 포함합니다.
struct SignLogIn_return: Decodable {
    let isSuccess: Bool
    let returnCode: Int
    let returnMsg: String
    let result: SignLogIn_result?
}

/// POST_SignIn 함수에 필요한 Struct
/// SignLogIn_return에 포함됩니다.
struct SignLogIn_result: Decodable {
    let userIdx: Int
    let jwt: String
}

/// PATCH_UserMod 함수에 필요한 Struct
struct ProfileMod_return: Decodable {
    let isSuccess: Bool
    let returnCode: Int
    let returnMsg: String
    let result: String?
}

/// GET_Post 함수에 필요한 Struct
/// Post, PostImage, PostCommentList 를 포함합니다.
struct GetPosts_return: Decodable {
    let isSuccess: Bool
    let returnCode: Int
    let returnMsg: String
    let result: [Post]?
}

/// GET_Post 함수에 필요한 Struct
/// GetPosts_return에 포함됩니다.
struct Post: Decodable {
    let postIdx: Int
    let userID: String
    let userProfileImg: String
    let postContent: String
    let commentNum: Int
    let uploadTime: String
    let imgList: [PostImage]?
    let commentList: [PostCommentList]?
}

/// GET_Post 함수에 필요한 Struct
/// Post에 포함됩니다.
struct PostImage: Decodable {
    let postImgIdx: Int
    let postImgUrl: String
}

/// GET_Post 함수에 필요한 Struct
/// Post에 포함됩니다.
struct PostCommentList: Decodable {
    let commentIdx: Int
    let commentContents: String
    let userID: String
}


/// GET_Profile 함수에 필요한 Struct
/// GetProfile_result 를 포함합니다.
struct GetProfile_return: Decodable {
    let isSuccess: Bool
    let returnCode: Int
    let returnMsg: String
    let result: GetProfile_result?
}

/// GET_Profile 함수에 필요한 Struct
/// GetProfile_return에 포함됩니다.
struct GetProfile_result: Decodable {
    let userIdx: Int
    let userName: String
    let userIntro: String?
    let userWebsite: String?
    let userProfileImg: String?
    let postNum: Int
    let followerNum: Int
    let followingNum: Int
    let userID: String
}


