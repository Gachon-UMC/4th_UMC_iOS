//
//  HomeViewController.swift
//  Instagram
//
//  Created by 박민서 on 2023/04/29.
//

import UIKit

///Instagram 클론코딩의 홈 View입니다
class HomeViewController: UIViewController {

    @IBOutlet weak var nav_bar: UINavigationBar!    // 상단 instagram logo navigation bar
    
    @IBOutlet weak var StoryTableView: UITableView! // 유저별로 생성된 StoryCell들이 표시되는 TableView
    
    let refreshControl = UIRefreshControl() //새로고침 객체입니다
    let Device_width = UIScreen.main.bounds.width // 기체 별 width 조절을 위한 변수 설정입니다.
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //네비게이션바 UI설정
        nav_bar.setBackgroundImage(UIImage(), for: .default)
        nav_bar.shadowImage = UIImage()
        
        
        addDummyStories() // Story 더미데이터 설정
        fetchPostData{  //서버에서 Post데이터 받아오고, completion 실행
            self.StoryTableView.reloadData() //화면 reload
        }
                
        
        //HomeView에서 사용하는 UserDefaults에 대한 초기설정
        getUserDefaults(forkey: "Story_List")
        //getUserDefaults(forkey: "Post_List")
        
        //StoryTableCell,PostTableCell를 담는 StoryTableView의 delegate,dataSource를 갖고옴
        self.StoryTableView.delegate = self
        self.StoryTableView.dataSource = self
        
        //StoryCollectionView가 들어갈 StoryTableViewCell Register
        let storyCell = UINib(nibName: "StoryTableViewCell", bundle: nil)
            StoryTableView.register(storyCell, forCellReuseIdentifier: "StoryTableViewCell")
        //PostCollectionView가 들어갈 PostTableViewCell Register
        let postCell = UINib(nibName: "PostTableViewCell", bundle: nil)
            StoryTableView.register(postCell, forCellReuseIdentifier: "PostTableViewCell")
        
        //StoryTableView에 새로고침 추가
        StoryTableView.addSubview(refreshControl)   // StoryTableView에 refreshControl SubView삽입
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged) // refresh될때 target, selector, 분기 지정
        
    }
    
    /// StoryTableView의 refreshControl이 실행되었을 때 호출되는 함수 입니다.
    @objc func refresh(_ sender: UIRefreshControl) {
        let item = DispatchWorkItem {   //DispatchQueue.main.asyncAfter의 execute에 들어갈 item을 설정.
            self.StoryTableView.reloadData() //화면 reload
            sender.endRefreshing()  //sender인 UIRefreshControl의 refreshing 끝내기
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: item) // 1초뒤에 비동기적으로 item을 실행하기 = endRefreshing()
        }
    
    ///UserDefaults의 값들을 불러오거나, 세팅하는 함수입니다.
    func getUserDefaults(forkey: String) {
        if let _ = UserDefaults.standard.data(forKey: forkey) { //forkey의 데이터가 이미 존재할때
            if forkey == "Post_List"{   //forkey가 Post_List, 이미 존재할 때
                if let storedData = UserDefaults.standard.data(forKey: "Post_List"), let PostList = try? JSONDecoder().decode([post].self, from: storedData) {
                    post_list = PostList    //데이터를 불러와서 post_list에 저장.
                }
            }
        } else {     //forkey의 데이터가 존재하지 않을때 -> 새로운 데이터 생성
            if forkey == "Story_List"{
                if let encodedData = try? JSONEncoder().encode(story_list) { //data로 저장하기위해 encoding
                    // 이때 story_list는 story객체의 리스트임 -> HomeView_dataStruct 참고
                    UserDefaults.standard.set(encodedData, forKey: forkey) // "Story_List" key로 저장
                    UserDefaults.standard.synchronize() //"Story_List" 데이터 즉시 동기화 -> UI 표시에 필요한 부분은 바로바로 동기화 되어야함
                }
            } else if forkey == "Post_List"{
                if let encodedData = try? JSONEncoder().encode(post_list) { //data로 저장하기위해 encoding
                    // 이때 post_list는 post객체의 리스트임 -> HomeView_dataStruct 참고
                    UserDefaults.standard.set(encodedData, forKey: forkey) // "Post_List" key로 저장
                    UserDefaults.standard.synchronize() //"Post_List" 데이터 즉시 동기화 -> UI 표시에 필요한 부분은 바로바로 동기화 되어야함
                }
            }
        }
        
    }

}

///HomeViewController의 extension -> UITableViewDelegate
extension HomeViewController: UITableViewDelegate{
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 120 : 570   //tableViewCell의 높이 수동 지정 0번째 셀 = 120, 나머지셀 570
    }
}

///HomeViewController의 extension -> UITableViewDataSource
extension HomeViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {   //tableView의 section 수
        return 2    //story셀 + post셀 2개
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {   //해당 section의 아이템 개수
        if section == 0 {   // story section
            return 1    //StoryTableViewCell이 들어가니 한개입니다. UserCell들은 CollectionView에서 처리
        }else { // post section
            return post_list.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {    //tableViewCell의 index마다 각 cell에 설정
        switch indexPath.section{
        case 0: //section이 0인 경우 -> StoryTableViewCell -> storyCollectionView
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as? StoryTableViewCell else { return UITableViewCell() }
            return cell
        case 1: // section이 1인 경우 -> PostTableViewCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
            cell.setData(post_list[indexPath.row])  //Post 셀의 해당 데이터를 셀 내의 setData를 통해 내부 설정
            return cell
        default: // 예상치 못한 에러인 경우
            print("unintended err")
            return UITableViewCell()
        }
    }
    
}
