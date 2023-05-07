//
//  HomeViewController.swift
//  Instagram
//
//  Created by 이재혁 on 2023/05/04.
//

import UIKit

struct story {
    var storyImage: String
    var userID: String
    var isWatch: Bool
    
    
    
}

extension story {
    static var data = [
        story(storyImage: "", userID: "내 스토리", isWatch: false),
        story(storyImage: "", userID: "jh", isWatch: true),
        story(storyImage: "", userID: "jhj", isWatch: true),
        story(storyImage: "", userID: "jhjhj", isWatch: true),
        story(storyImage: "", userID: "aiai", isWatch: true),
        story(storyImage: "", userID: "swsw", isWatch: true),
    ]
}

struct feed {
    var profileImg: String
    var profileID: String
    var feedImg: String
    var like: Int
    var feedText: String
    var comment: Int
}

extension feed {
    static var data = [
        feed(profileImg: "myPost4", profileID: "jhjh98", feedImg: "myPost1", like: 123, feedText: "너무슬퍼요", comment: 12),
        feed(profileImg: "myPost4", profileID: "aiaikoi", feedImg: "myPost2", like: 123, feedText: "하하", comment: 12),
        feed(profileImg: "myPost4", profileID: "bokdolLee", feedImg: "myPost3", like: 123, feedText: "하하하하", comment: 12),
    ]
}

let dataList = feed.data

class HomeViewController: UIViewController {
    
    var storyData = [Model]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        setUpTableView()
        tableView.register(UINib(nibName: "firstCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "firstCollectionTableViewCell")
        //tableView.estimatedRowHeight = 631
        
        
        //register Story
        
    }
    
    //StoryTableView
    func setUpTableView() {
        storyData.append(Model(storyImage: "Default_pfp_1", userID: "내 스토리", isWatch: false))
        storyData.append(Model(storyImage: "myPost2", userID: "jh", isWatch: true))
        storyData.append(Model(storyImage: "myPost3", userID: "jj", isWatch: true))
        storyData.append(Model(storyImage: "myPost4", userID: "jjh", isWatch: true))
        storyData.append(Model(storyImage: "myPost1", userID: "hhj", isWatch: true))
        storyData.append(Model(storyImage: "myPost2", userID: "hjh", isWatch: true))
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstCollectionTableViewCell", for: indexPath) as! firstCollectionTableViewCell
                    cell.configure(with: storyData)
                    return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            
            let target = dataList[indexPath.row-1]
            
            let profileImg = UIImage(named: "\(target.profileImg)")
            let feedImg = UIImage(named: "\(target.feedImg)")
            
            cell.feedImg?.image = feedImg
            cell.profileImg?.image = profileImg
            
            cell.profileID.text = target.profileID
            cell.feedUserID.text = target.profileID
            cell.likeCount.text = "좋아요 \(target.like)개"
            cell.commentCount.text = "댓글 \(target.comment)개 모두 보기"
            cell.commentCount.textColor = UIColor.lightGray
            cell.Nakami.text = "\(target.feedText)"
            
            
            return cell
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { return 100 }
        else {return 631}
    }
    
//    func storyTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //cell의 갯수 설정
//            return 1
//        }
//
//    func storyTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //cell의 데이터 구성
//        let cell = storyTableView.dequeueReusableCell(withIdentifier: "firstCollectionTableViewCell", for: indexPath) as! firstCollectionTableViewCell
//        cell.configure(with: storyData)
//        return cell
//    }
//
//    func storyTableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { //cell의 높이 설정
//        return 120
//    }
    
    
}


