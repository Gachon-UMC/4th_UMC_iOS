//
//  StoryModel.swift
//  Instagram
//
//  Created by 이재혁 on 2023/05/07.
//

struct Model: Codable {
    let storyImage: String
    let userID: String
    var isWatch: Bool
    let mainImage: String
    let date: String
    var storyIsWatch: Bool
    var isHeartFilled: Bool
    var isMine: Bool
    
    init(storyImage: String, userID: String, isWatch: Bool, mainImage: String, date: String, isMine: Bool) {
        self.storyImage = storyImage
        self.userID = userID
        self.isWatch = isWatch
        self.mainImage = mainImage
        self.date = date
        self.storyIsWatch = false
        self.isHeartFilled = false
        self.isMine = isMine
    }
}
