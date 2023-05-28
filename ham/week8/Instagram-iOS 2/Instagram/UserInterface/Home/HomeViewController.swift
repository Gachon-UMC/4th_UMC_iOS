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
    var feedData = [FeedModel]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initRefresh()
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        setUpTableView()
        setUpFeed()
        
        //23.5.19 : storyData 불러와서 set
        if let _ = UserDefaults.standard.data(forKey: "Story_List") {
        } else {
            if let encodedData = try? JSONEncoder().encode(storyData) {
                UserDefaults.standard.set(encodedData, forKey: "Story_List")
                UserDefaults.standard.synchronize()
            }
        }
        
        // MARK: feedData 불러와서 set
        if let storedData = UserDefaults.standard.data(forKey: "Feed_List") {
            var feedList = try? JSONDecoder().decode([FeedModel].self, from: storedData)
            feedData = feedList!
        } else {
            if let encodedData = try? JSONEncoder().encode(feedData) {
                UserDefaults.standard.set(encodedData, forKey: "Feed_List")
                UserDefaults.standard.synchronize()
            }
        }
    
        
        tableView.register(UINib(nibName: "firstCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "firstCollectionTableViewCell")
        
        //register Story
        
    }
    
    //feed setup
    func setUpFeed() {
        feedData.append(FeedModel(profileImg: "myPost4", profileID: "jhjh98", feedImg: "myPost1", like: 123, feedText: "너무슬퍼요", comment: 12, date: "1월 23일"))
        feedData.append(FeedModel(profileImg: "myPost4", profileID: "aiaikoi", feedImg: "myPost2", like: 111, feedText: "하하", comment: 12, date: "5월 19일"))
        feedData.append(FeedModel(profileImg: "myPost4", profileID: "bokdolLee", feedImg: "myPost3", like: 567, feedText: "하하하하", comment: 12, date: "11월 14일"))
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
        return feedData.count + 1
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
            cell.selectionStyle = .none
            let target = feedData[indexPath.row-1]
            
            let profileImg = UIImage(named: "\(target.profileImg)")
            let feedImg = UIImage(named: "\(target.feedImg)")
            
            cell.feedImg?.image = feedImg
            cell.profileImg?.image = profileImg
            // 2023.5.13 피드 프로필 이미지 둥글게..
            cell.profileImg.layer.cornerRadius = cell.profileImg.frame.width / 2.0
            // 2023.5.28 셀 UI 정보 받아오기 -> tableviewcell에서..
            cell.configure(feedmodel: target)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { return 100 }
        else {return 631}
    }
    
    
}


