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
    var date: String
}

extension feed {
    static var data = [
        feed(profileImg: "myPost4", profileID: "jhjh98", feedImg: "myPost1", like: 123, feedText: "너무슬퍼요", comment: 12, date: "1월 23일"),
        feed(profileImg: "myPost4", profileID: "aiaikoi", feedImg: "myPost2", like: 123, feedText: "하하", comment: 12, date: "5월 19일"),
        feed(profileImg: "myPost4", profileID: "bokdolLee", feedImg: "myPost3", like: 123, feedText: "하하하하", comment: 12, date: "11월 14일"),
    ]
}

let dataList = feed.data

class HomeViewController: UIViewController {
    
    // 2023.05.11 새로고침 표시
    //--------------------------------------------------------
    @IBOutlet weak var scrollView: UIScrollView!
    let refreshControl = UIRefreshControl()
    
    func initRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    @objc func refreshTable(refresh: UIRefreshControl) {
        print("새로고침 시작")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            //self.tableView.reloadData()
            refresh.endRefreshing()
        }
    }
    //--------------------------------------------------------
    var storyData = [Model]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initRefresh()
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        setUpTableView()
        
        //23.5.19 : storyData 불러와서 set
        if let _ = UserDefaults.standard.data(forKey: "Story_List") {
        } else {
            if let encodedData = try? JSONEncoder().encode(storyData) {
                UserDefaults.standard.set(encodedData, forKey: "Story_List")
                UserDefaults.standard.synchronize()
            }
        }
        
        tableView.register(UINib(nibName: "firstCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "firstCollectionTableViewCell")
        
        
        
        //register Story
        
    }
    
    //StoryTableView
    func setUpTableView() {
        storyData.append(Model(storyImage: "Default_pfp_1", userID: "내 스토리", isWatch: false, mainImage: "myPost1", date: "23시간", isMine: true))
        storyData.append(Model(storyImage: "myPost2", userID: "jh", isWatch: true, mainImage: "myPost3", date: "2시간", isMine: false))
        storyData.append(Model(storyImage: "myPost3", userID: "jj", isWatch: true, mainImage: "myPost4", date: "20시간", isMine: false))
        storyData.append(Model(storyImage: "myPost4", userID: "jjh", isWatch: true, mainImage: "myPost2", date: "21시간", isMine: false))
        storyData.append(Model(storyImage: "myPost1", userID: "hhj", isWatch: true, mainImage: "myPost3", date: "22시간", isMine: false))
        storyData.append(Model(storyImage: "myPost2", userID: "hjh", isWatch: true, mainImage: "myPost4", date: "3시간", isMine: false))
        
    }
}

//23.5.19
extension HomeViewController: firstCollectionTableViewCellDelegate {
    func didTapImageView(with model: Model) {
        
        if let storedData = UserDefaults.standard.data(forKey: "Story_List"), var StoryList = try? JSONDecoder().decode([Model].self, from: storedData) {
            for i in 1..<StoryList.count {
                if StoryList[i].userID == model.userID {
                    if StoryList[i].storyIsWatch == true {}
                    else {
                        StoryList[i].storyIsWatch = true
                        let story = StoryList.remove(at: i)
                        StoryList.append(story)
                    }
                    break
                }
            }
            if let updateStoryList = try? JSONEncoder().encode(StoryList) {
                UserDefaults.standard.set(updateStoryList, forKey: "Story_List")
                UserDefaults.standard.synchronize()
            }
        }
        
        let vc = DelayViewController(nibName: "DelayViewController", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.profileInStory = UIImage(named: model.storyImage)
        vc.userIDInStory = model.userID
        vc.dayAgoInStory = model.date
        vc.mainStoryImageInStory = UIImage(named: model.mainImage)
        vc.isHeartFilled = model.isHeartFilled
        
        let indexSet = IndexSet(integer: 0)
        self.tableView.reloadSections(indexSet, with: .automatic)
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
}
//-------

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstCollectionTableViewCell", for: indexPath) as! firstCollectionTableViewCell
                    cell.configure(with: storyData)
            cell.delegate = self
                    return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            
            let target = dataList[indexPath.row-1]
            
            let profileImg = UIImage(named: "\(target.profileImg)")
            let feedImg = UIImage(named: "\(target.feedImg)")
            
            cell.feedImg?.image = feedImg
            cell.profileImg?.image = profileImg
            // 2023.5.13 피드 프로필 이미지 둥글게..
            cell.profileImg.layer.cornerRadius = cell.profileImg.frame.width / 2.0
            
            cell.profileID.text = target.profileID
            cell.feedUserID.text = target.profileID
            cell.likeCount.text = "좋아요 \(target.like)개"
            cell.commentCount.text = "댓글 \(target.comment)개 모두 보기"
            cell.commentCount.textColor = UIColor.lightGray
            cell.Nakami.text = "\(target.feedText)"
            cell.dateLabel.text = "\(target.date)"
            cell.dateLabel.textColor = UIColor.lightGray
            
            
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


