//
//  HomeViewController.swift
//  Instagram
//
//  Created by YOUJIM on 2023/04/29.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var postView: UITableView!
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    var models = [Model]()
    var posts = [Post]()
    
    // 새로고침을 위해 UIRefreshControl 인스턴스 생성
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //refreshControl 추가
        initRefresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpPostView()
        postView.reloadData()
    }
    
    // 처음 생성된 refreshControl에 addTarget 매칭
    func initRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh: )), for: .valueChanged)
        postView.refreshControl = refreshControl
    }
    
    // refreshControl이 동작했을 때 실행될 함수
    @objc func refreshTable(refresh: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            refresh.beginRefreshing()
            //데이터 다시 불러와서 새로고침
            self.postView.reloadData()
            refresh.endRefreshing()
        }
    }
    
    func setUpPostView() {
        // 저장된 스토리 배열 decode해서 불러오기
        if let model = UserDefaults.standard.object(forKey: "storyLists") as? Data {
            if let savedObject = try? decoder.decode([Model].self, from: model) {
                models = savedObject
                print("print models: \(models)")
            }
        }
        
        if models.count == 0 {
            models.append(Model(imagename: "storyImage6", id: "내 스토리", isWatch: false, isNotMine: false, hasActiveStory: true, storyName: "storyImage1", isHeartFilled: false))
            models.append(Model(imagename: "storyImage3", id: "jokebear", isWatch: false, isNotMine: true, hasActiveStory: true, storyName: "storyImage6", isHeartFilled: false))
            models.append(Model(imagename: "storyImage1", id: "youz2me", isWatch: false, isNotMine: true, hasActiveStory: true, storyName: "storyImage2", isHeartFilled: false))
            models.append(Model(imagename: "storyImage4", id: "ddong2", isWatch: false, isNotMine: true, hasActiveStory: true, storyName: "storyImage3", isHeartFilled: false))
            models.append(Model(imagename: "storyImage5", id: "gachon_umc", isWatch: false, isNotMine: true, hasActiveStory: true, storyName: "storyImage4", isHeartFilled: false))
            models.append(Model(imagename: "storyImage6", id: "zimging", isWatch: false, isNotMine: true, hasActiveStory: true, storyName: "storyImage5", isHeartFilled: false))
        }
        if posts.count == 0 {
            posts.append(Post(info: Model(imagename: "storyImage1", id: "youz2me", isWatch: true, isNotMine: false, hasActiveStory: false, storyName: "", isHeartFilled: false), imageName: UIImage(named: "storyImage6")!, imageComment: "집에갈래", numOfLike: 2, numOfComment: 3, month: 5, day: 1))
            posts.append(Post(info: Model(imagename: "jokebear2", id: "bearjoke", isWatch: true, isNotMine: true, hasActiveStory: false, storyName: "", isHeartFilled: false), imageName: UIImage(named: "jokebear2")!, imageComment: "농담곰", numOfLike: 10, numOfComment: 5, month: 5, day: 2))
            posts.append(Post(info: Model(imagename: "jokebear3", id: "jokebear", isWatch: true, isNotMine: true, hasActiveStory: false, storyName: "", isHeartFilled: false), imageName: UIImage(named: "jokebear3")!, imageComment: "귀엽죠?", numOfLike: 1100, numOfComment: 5, month: 5, day: 3))
        }
        
        postView.delegate = self
        postView.dataSource = self
        postView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
        postView.register(UINib(nibName: "firstCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "firstCollectionTableViewCell")
        postView.separatorStyle = .none
    }


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //cell의 갯수 설정
        return posts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstCollectionTableViewCell", for: indexPath) as! firstCollectionTableViewCell
            cell.configure(with: models)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
            cell.configure(with: posts[indexPath.row - 1])
            return cell
        }
    }
}
