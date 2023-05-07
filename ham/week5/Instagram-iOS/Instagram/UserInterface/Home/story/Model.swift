//
//  StoryModel.swift
//  Instagram
//
//  Created by 이재혁 on 2023/05/07.
//

struct Model {
    let storyImage: String
    let userID: String
    var isWatch: Bool
    
    init(storyImage: String, userID: String, isWatch: Bool) {
        self.storyImage = storyImage
        self.userID = userID
        self.isWatch = isWatch
    }
}
