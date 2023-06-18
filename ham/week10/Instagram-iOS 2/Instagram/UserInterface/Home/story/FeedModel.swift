//
//  FeedModel.swift
//  Instagram
//
//  Created by 이재혁 on 2023/05/25.
//

import Foundation

struct FeedModel: Codable {
    var profileImg: String
    var profileID: String
    var feedImg: String
    var like: Int
    var feedText: String
    var comment: Int
    var date: String
    var isHeartFilled: Bool
    
    init(profileImg: String, profileID: String, feedImg: String, like: Int, feedText: String, comment: Int, date: String) {
        self.profileImg = profileImg
        self.profileID = profileID
        self.feedImg = feedImg
        self.like = like
        self.feedText = feedText
        self.comment = comment
        self.date = date
        self.isHeartFilled = false
    }
}
