//
//  Model.swift
//  Instagram
//
//  Created by YOUJIM on 2023/04/29.
//

import UIKit

struct Model {
    let imagename: UIImage
    let id: String
    var isWatch: Bool
    
    init(imagename: UIImage, id: String, isWatch: Bool) {
        self.imagename = imagename
        self.id = id
        self.isWatch = isWatch
    }
}

struct Post {
    let info: Model
    let imageName: UIImage
    var imageComment: String
    var numOfLike: Int
    var numOfComment: Int
    let month: Int
    let day: Int
    
    init(info: Model, imageName: UIImage, imageComment: String, numOfLike: Int, numOfComment: Int, month: Int, day: Int) {
        self.info = info
        self.imageName = imageName
        self.imageComment = imageComment
        self.numOfLike = numOfLike
        self.numOfComment = numOfComment
        self.month = month
        self.day = day
    }
}
