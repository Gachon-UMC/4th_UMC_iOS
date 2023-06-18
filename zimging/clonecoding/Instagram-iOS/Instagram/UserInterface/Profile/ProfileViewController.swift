//
//  ProfileViewController.swift
//  Instagram
//
//  Created by 서은수 on 2022/09/19.
//

import UIKit
import Alamofire
import AlamofireImage

// jwt를 보내 받아올 정보를 저장할 구조체 선언
// MARK: - UserResponse
struct UserResponse: Codable {
    let isSuccess: Bool
    let returnCode: Int
    let returnMsg: String
    let result: Info
}

// MARK: - UserInfo
struct Info: Codable {
    let userIdx: Int
    let userName: String
    let userIntro: String?
    let userWebsite: String?
    let userProfileImg: String?
    let postNum: Int?
    let followerNum: Int?
    let followingNum: Int?
    let userID: String
}

protocol SendDataToEdit {
    func SendDataToE (myName: String, myID: String, myIntro: String, myLink: String)
}

class ProfileViewController: UIViewController, SendDataToProfile {
    func sendDataToP(myName: String, myID: String, myIntro: String, myLink: String) {
        name.text = myName
        id.text = myID
        intro.text = myIntro
        link.text = myLink
    }
    
    var delegate: SendDataToEdit?
    
    // 로그인 페이지에서 받아올 jwt를 담을 객체
    var jwt = ""
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) { }
    
    @IBAction func editBtn(_ sender: Any) {
        performSegue(withIdentifier: "goToEdit", sender: self)
    }
    
    @IBOutlet weak var grid: UIButton!
    @IBOutlet weak var tag: UIButton!
    
    @IBAction func grid(_ sender: Any) {
        grid.tintColor = UIColor.black
        tag.tintColor = UIColor.gray
        gridView.backgroundColor = UIColor.black
        tagView.backgroundColor = UIColor.clear
    }
    
    @IBAction func tag(_ sender: Any) {
        grid.tintColor = UIColor.gray
        tag.setImage(UIImage(systemName: "postGrid"), for: .normal)
        tag.tintColor = UIColor.black
        gridView.backgroundColor = UIColor.clear
        tagView.backgroundColor = UIColor.black
    }
    
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var gridView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var intro: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var link: UILabel!
    @IBOutlet weak var followingNum: UILabel!
    @IBOutlet weak var followerNum: UILabel!
    @IBOutlet weak var postNum: UILabel!
    @IBOutlet weak var profileImg: UIButton!
    
    @IBAction func backToPage(_ sender: UIStoryboardSegue) {
    }
    
    @available(iOS 16.0, *)
    @IBAction func hamburgerBtn(_ sender: Any) {
        let settingVC = SettingViewController()
        settingVC.modalPresentationStyle = .formSheet
        
        if let sheet = settingVC.sheetPresentationController {
            // VC 높이의 60%까지 올려줌
            let multiplier = 0.6
            let fraction = UISheetPresentationController.Detent.custom { context in
                settingVC.view.frame.height * multiplier
            }
            sheet.detents = [fraction]
            // grabber...? 그 회색 위에 있는 조그만 막대 같은 거 표시해줌
            sheet.prefersGrabberVisible = true
            // 중간 이상으로는 스크롤 안되게 막아줌
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        //화면에 뿌려줌
        present(settingVC, animated: true)
    }
    
    @IBAction func addPostBtn(_ sender: Any) {
        let addPostVC = AddPostViewController()
        
        if let sheet = addPostVC.sheetPresentationController {
            // 중간 높이까지만 올려줌
            sheet.detents = [ .medium() ]
            // grabber...? 그 회색 위에 있는 조그만 막대 같은 거 표시해줌
            sheet.prefersGrabberVisible = true
            // 중간 이상으로는 스크롤 안되게 막아줌
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        //화면에 뿌려줌
        present(addPostVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 로그인에서 userDefault로 세팅한 jwt값 가져오기
        jwt = UserDefaults.standard.string(forKey: "jwt") ?? "불러오기 실패"
        
        getUserInfo(jwt: jwt) { result in
            switch result {
            case .success(let userResponse):
                print("유저 정보 조회 성공")
                let userInfo = userResponse.result
                print("User Index: \(userInfo.userIdx)")
                print("User Name: \(userInfo.userName)")
                print("User Intro: \(userInfo.userIntro)")
                print("User Website: \(userInfo.userWebsite)")
                print("User Profile Image: \(userInfo.userProfileImg)")
                print("Post Number: \(userInfo.postNum)")
                print("Follower Number: \(userInfo.followerNum)")
                print("Following Number: \(userInfo.followingNum)")
                print("User ID: \(userInfo.userID)")
                
                // 유저 정보 화면에 뿌려줌
                self.name.text = userInfo.userName
                self.id.text = userInfo.userID
                self.intro.text = userInfo.userIntro
                self.link.text = userInfo.userWebsite
                self.followerNum.text = String(userInfo.followerNum!)
                self.followingNum.text = String(userInfo.followingNum!)
                self.postNum.text = String(userInfo.postNum!)
                
                // 이미지를 다운로드하여 버튼에 설정
                AF.request(userInfo.userProfileImg ?? "").responseImage { response in
                    switch response.result {
                    case .success(let image):
                        // 이미지 다운로드 성공 시 버튼에 이미지 설정
                        self.profileImg.setImage(image, for: .normal)
                    case .failure(let error):
                        // 이미지 다운로드 실패 시 에러 처리
                        print("프로필 이미지 없음: \(error)")
                    }
                }
                
            case .failure(let error):
                print("유저 정보 조회 실패: \(error)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEdit" {
            let vc = segue.destination as! EditViewController
            vc.name = name.text!
            vc.id = id.text!
            vc.intro = intro.text ?? ""
            vc.link = link.text ?? ""
            vc.jwt = jwt
            vc.delegate = self //이건 왜 해주는거지? 중간끝나고 봐야지 -> 위임자를 선택해주는 거라고 함
        }
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UICollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewWidth = collectionView.bounds.width
            let cellItemForRow: CGFloat = 3
            let minimumSpacing: CGFloat = 2
            
            let width = (collectionViewWidth - (cellItemForRow - 1) * minimumSpacing) / cellItemForRow
            
            return CGSize(width: width, height: width)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 2
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 2
        }
}

// 유저 정보 request
func getUserInfo(jwt: String, completion: @escaping (Result<UserResponse, Error>) -> Void) {
    let headers: HTTPHeaders = ["X-ACCESS-TOKEN": jwt]
    
    AF.request(APIConstants.profileURL, headers: headers)
        .validate()
        .responseDecodable(of: UserResponse.self) { response in
            switch response.result {
            case .success(let userResponse):
                completion(.success(userResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
}
