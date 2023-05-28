//
//  Model.swift
//  Instagram
//
//  Created by YOUJIM on 2023/04/29.
//

import UIKit

struct Model: Codable, Equatable {
    let imagename: String
    let id: String
    var isWatch: Bool
    var hasActiveStory: Bool
    var storyName: String
    var isNotMine: Bool
    var isHeartFilled: Bool
    
    init(imagename: String, id: String, isWatch: Bool, isNotMine: Bool, hasActiveStory: Bool, storyName: String, isHeartFilled: Bool) {
        self.imagename = imagename
        self.id = id
        self.isWatch = isWatch
        self.hasActiveStory = hasActiveStory
        self.storyName = storyName
        self.isNotMine = isNotMine
        self.isHeartFilled = isHeartFilled
    }
}

struct Post: Codable, Equatable {
    let info: Model
    let imageName: String
    var imageComment: String
    var numOfLike: Int
    var numOfComment: Int
    let month: Int
    let day: Int
    var isHeartFilled: Bool
    
    init(info: Model, imageName: String, imageComment: String, numOfLike: Int, numOfComment: Int, month: Int, day: Int, isHeartFilled: Bool) {
        self.info = info
        self.imageName = imageName
        self.imageComment = imageComment
        self.numOfLike = numOfLike
        self.numOfComment = numOfComment
        self.month = month
        self.day = day
        self.isHeartFilled = isHeartFilled
    }
}

struct forPostConfigure {
    var posts : [Post]
    var index : Int
}
