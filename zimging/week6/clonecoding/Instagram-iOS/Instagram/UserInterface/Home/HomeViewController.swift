//
//  HomeViewController.swift
//  Instagram
//
//  Created by YOUJIM on 2023/04/29.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var postView: UITableView!
    
    var models = [Model]()
    var posts = [Post]()
    
    // 새로고침을 위해 UIRefreshControl 인스턴스 생성
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPostView()
        //refreshControl 추가
        initRefresh()
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
        models.append(Model(imagename: UIImage(named: "jokebear1")!, id: "내 스토리", isWatch: false))
        models.append(Model(imagename: UIImage(named: "jokebear1")!, id: "name2", isWatch: true))
        models.append(Model(imagename: UIImage(named: "jokebear1")!, id: "name3", isWatch: true))
        models.append(Model(imagename: UIImage(named: "jokebear1")!, id: "name4", isWatch: true))
        models.append(Model(imagename: UIImage(named: "jokebear1")!, id: "name5", isWatch: true))
        models.append(Model(imagename: UIImage(named: "jokebear1")!, id: "name6", isWatch: true))
        posts.append(Post(info: Model(imagename: UIImage(named: "jokebear1")!, id: "youz2me", isWatch: true), imageName: UIImage(named: "jokebear1")!, imageComment: "집에갈래", numOfLike: 2, numOfComment: 3, month: 5, day: 1))
        posts.append(Post(info: Model(imagename: UIImage(named: "jokebear2")!, id: "bearjoke", isWatch: true), imageName: UIImage(named: "jokebear2")!, imageComment: "농담곰", numOfLike: 10, numOfComment: 5, month: 5, day: 2))
        posts.append(Post(info: Model(imagename: UIImage(named: "jokebear3")!, id: "jokebear", isWatch: true), imageName: UIImage(named: "jokebear3")!, imageComment: "귀엽죠?", numOfLike: 1100, numOfComment: 5, month: 5, day: 3))
        
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
