//
//  Model.swift
//  Instagram
//
//  Created by YOUJIM on 2023/04/29.
//

struct Model {
    let imagename: String
    let id: String
    var isWatch: Bool
    
    init(imagename: String, id: String, isWatch: Bool) {
        self.imagename = imagename
        self.id = id
        self.isWatch = isWatch
    }
}
