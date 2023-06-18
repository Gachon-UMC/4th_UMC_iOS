//
//  HomeViewController.swift
//  Instagram
//
//  Created by YOUJIM on 2023/04/29.
//

import UIKit
import Alamofire
import AlamofireImage

// MARK: 응답을 받을 구조체 생성
// TODO: AF.request로 받아서 Post 구조체에 연결하기
struct PostResponse: Codable {
    let isSuccess: Bool
    let returnCode: Int
    let returnMsg: String
    let result: [PostInfo]
}

struct PostInfo: Codable {
    let postIdx: Int
    let userProfileImg: String
    let postContent: String
    let commentNum: Int
    let uploadTime: String
    let imgList: [PostImage]
    let commentList: [Comment]
    let userID: String
}

struct PostImage: Codable {
    let postImgIdx: Int
    let postImgUrl: String
}

struct Comment: Codable {
    let commentIdx: Int
    let commentContents: String
    let userID: String
}


class HomeViewController: UIViewController {
    
    // 로그인 페이지에서 받아올 jwt를 담을 객체
    var jwt = ""
    
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
        // 로그인에서 userDefault로 세팅한 jwt값 가져오기
        jwt = UserDefaults.standard.string(forKey: "jwt") ?? "불러오기 실패"
        
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
            }
        }
        
        // 저장된 게시물 배열 decode해서 불러오기
        if let post = UserDefaults.standard.object(forKey: "postLists") as? Data {
            if let savedObject = try? decoder.decode([Post].self, from: post) {
                posts = savedObject
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
            getPostList(jwt: jwt) { result in
                switch result {
                case .success(let postResponse):
                    print("게시물 정보 조회 성공")
                    // 게시물 수만큼 posts 배열에 추가
                    for post in postResponse.result {
                        if let dayString = post.uploadTime.components(separatedBy: CharacterSet.decimalDigits.inverted).first,
                           let daysAgo = Int(dayString) {
                            // 추출한 n을 Int 형식으로 저장
                            print("n: \(daysAgo)")

                            // 현재 날짜 가져오기
                            let currentDate = Date()
                            let calendar = Calendar.current
                            var components = calendar.dateComponents([.month, .day], from: currentDate)

                            if let month = components.month, var day = components.day {
                                // 월과 일을 Int 형식으로 저장하고 날짜 계산
                                day -= daysAgo
                                // 게시물에 추가
                                self.posts.append(Post(info: Model(imagename: post.userProfileImg, id: post.userID, isWatch: true, isNotMine: true, hasActiveStory: false, storyName: "", isHeartFilled: false), imageName: post.imgList[0].postImgUrl, imageComment: post.postContent, numOfLike: 43, numOfComment: post.commentNum, month: month, day: day, isHeartFilled: false))
                            } else {
                                // 날짜 구성 요소를 가져오지 못한 경우
                                print("날짜를 불러올 수 없음.")
                            }
                        } else {
                            // 추출에 실패한 경우
                            print("n을 추출할 수 없음")
                        }
                    }
                case .failure(let error):
                    print("게시물 정보 조회 실패: \(error)")
                }
            }
//            posts.append(Post(info: Model(imagename: "storyImage1", id: "youz2me", isWatch: true, isNotMine: false, hasActiveStory: false, storyName: "", isHeartFilled: false), imageName: "storyImage6", imageComment: "집에갈래", numOfLike: 2, numOfComment: 3, month: 5, day: 1, isHeartFilled: false))
//            posts.append(Post(info: Model(imagename: "jokebear2", id: "bearjoke", isWatch: true, isNotMine: true, hasActiveStory: false, storyName: "", isHeartFilled: false), imageName: "jokebear2", imageComment: "농담곰", numOfLike: 10, numOfComment: 5, month: 5, day: 2, isHeartFilled: false))
//            posts.append(Post(info: Model(imagename: "jokebear3", id: "jokebear", isWatch: true, isNotMine: true, hasActiveStory: false, storyName: "", isHeartFilled: false), imageName: "jokebear3", imageComment: "귀엽죠?", numOfLike: 1100, numOfComment: 5, month: 5, day: 3, isHeartFilled: false))
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
            cell.configure(with: forPostConfigure(posts: posts, index: indexPath.row - 1))
            return cell
        }
    }
}

// 게시물 정보 request
func getPostList(jwt: String, completion: @escaping (Result<PostResponse, Error>) -> Void) {
    let headers: HTTPHeaders = ["X-ACCESS-TOKEN": jwt]
    
    AF.request(APIConstants.homeListURL, method: .get, headers: headers)
        .validate()
        .responseDecodable(of: PostResponse.self) { response in
            switch response.result {
            case .success(let postResponse):
                completion(.success(postResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
}
