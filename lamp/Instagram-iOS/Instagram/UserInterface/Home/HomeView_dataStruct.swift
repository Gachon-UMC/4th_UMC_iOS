//
//  story_data.swift
//  Instagram
//
//  Created by 박민서 on 2023/04/29.
//

import Foundation

//Story Cell에 저장될 데이터의 구조체
struct story: Codable { // de/encoding을 위해 Codable protocol
    let name: String    //user의 이름
    let image: String   //user의 프로필이미지
    let StoryImage: String  //user의 스토리이미지
    let time: String    //user 스토리의 업로드된 시간
    
    var isViewed: Bool  //user의 스토리를 봤는지 Boolean
    var gotHeart: Bool  //user의 스토리에 하트를 눌렀는지 Boolean
    
    init(_ name: String, _ image: String, _ StoryImage: String, _ time: String) {
        self.name = name
        self.image = image
        self.StoryImage = StoryImage
        self.time = time
        self.isViewed = false   //default를 false값
        self.gotHeart = false
    }
}

//Post Cell에 저장될 데이터의 구조체
struct post: Codable {
    let UserImage: String   //user의 이미지
    let PostImage: String   //user의 포스트 이미지
    var PostLike: Int   //user의 포스팅에 좋아요 개수
    let UserID: String  //User의 ID
    let UserText: String    //user의 포스트본문
    let CommentCount : Int  //user 포스팅의 댓글 개수
    let PostDate: String    //user 포스팅의 업로드된 시간
    var GotHeart: Bool  //user 포스팅의 하트 유무
    
    init(_ UserID: String, _ UserImage: String,_ PostImage: String, _ PostLike: Int, _ UserText: String, _ CommentCount: Int, _ PostDate: String) {
        self.UserID = UserID
        self.UserImage = UserImage
        self.PostImage = PostImage
        self.PostLike = PostLike
        self.UserText = UserText
        self.CommentCount = CommentCount
        self.PostDate = PostDate
        self.GotHeart = false // 디폴트값

    }
    
}

//story, post 객체들이 저장되는 리스트
var story_list: [story] = []
var post_list: [post] = []

///story 더미데이터 생성
func addDummyStories() {
    story_list.append(story("Lamp","DefaultProfile","Story1","3시간"))
    story_list.append(story("Name1","Image1","Story1","5시간"))
    story_list.append(story("Name2","Image2","Story2","4시간"))
    story_list.append(story("Name3","Image3","Story3","7시간"))
    story_list.append(story("Name4","Image4","Story4","3시간"))
    story_list.append(story("Name5","Image5","Story5","1시간"))
    story_list.append(story("Name6","Image6","Story6","2시간"))
}

////post 더미데이터 생성
func addDummyPosts() {
    post_list.append(post("Name1", "Image1", "Image4", 1, "하늘이 파랗네요", 1, "5월 3일"))
    post_list.append(post("Name2", "Image2", "Image5", 2, "하늘이 빨갛네요", 2, "5월 2일"))
    post_list.append(post("Name3", "Image3", "Image6", 3, "하늘이 노랗네요", 3, "5월 1일"))
}
