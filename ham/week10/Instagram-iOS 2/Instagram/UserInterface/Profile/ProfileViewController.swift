//
//  ProfileViewController.swift
//  Instagram
//
//  Created by 서은수 on 2022/09/19.
//

import UIKit
import Alamofire

struct Test {
    var image: String
}

extension Test {
    static var data = [
        Test(image: "myPost1"),
        Test(image: "myPost2"),
        Test(image: "myPost3"),
        Test(image: "myPost4"),
    ]
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

//2023.05.11 만들기버튼, 햄버거 버튼 바텀시트 구현
extension ViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        
        }
}

extension HamburgerBottomSheetViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        
        }
}

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, SendStringData {
    
    
    @IBOutlet weak var makeButton: UIButton!
    @IBOutlet weak var hamburgerButton: UIButton!
    
    @IBAction func tapMakeButton(_ sender: Any) {
        showMyMakeViewController()
    }
    @IBAction func tapHamburgerButton(_ sender: Any) {
        showMyHamburgerBottomSheetViewController()
    }
    
    func showMyMakeViewController() {
        let navigationController = UINavigationController(rootViewController: ViewController())
        present(navigationController, animated: true, completion: nil)
    }
    
    func showMyHamburgerBottomSheetViewController() {
        let navigationController = UINavigationController(rootViewController: HamburgerBottomSheetViewController())
        present(navigationController, animated: true, completion: nil)
    }
    
    //--------------------------------------------- 5/11
    
    
    
    // postGrid, tag
    @IBOutlet weak var postGrid: UIButton!
    @IBOutlet weak var tag: UIButton!
    @IBOutlet weak var postGridView: UIView!
    @IBOutlet weak var tagView: UIView!
    
    
    @IBAction func postGrid(_ sender: Any) {
        postGrid.tintColor = UIColor.black
        tag.tintColor = UIColor.gray
        postGridView.backgroundColor = UIColor.black
        tagView.backgroundColor = UIColor.clear
    }
    @IBAction func tag(_ sender: Any) {
        postGrid.tintColor = UIColor.gray
        tag.tintColor = UIColor.black
        postGridView.backgroundColor = UIColor.clear
        tagView.backgroundColor = UIColor.black
    }
    
    
    
    
    let testList = Test.data
    let cellName = "TestListCell"
    let cellReuseIdentifier = "testCell"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        testList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as?
                TestListCell else {
            return UICollectionViewCell()
        }
        let target = testList[indexPath.row]
        
        let img = UIImage(named: "\(target.image).png")
        cell.testImage?.image = img
        
        return cell
    }
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func sendData(mydata: String, myUserName: String, myIntro: String, myLink: String) {
        nameText.text = mydata
        userNameText.text = myUserName
        introText.text = myIntro
        linkTitle = myLink
        userWebsiteBtn.setTitle(myLink, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MypageGET() { result in
            guard let result = result else {
                print("Failed to get data.")
                return
            }
            
            DispatchQueue.main.async {
                // Get 통해 불러온 변수 연결
                self.followerNum.setTitle("\(result.followerNum!)", for: .normal)
                self.followingNum.setTitle("\(result.followingNum!)", for: .normal)
                self.introText.text = result.userIntro
                self.userNameText.text = result.userID
                self.nameText.text = result.userName
                self.linkTitle = result.userWebsite ?? ""
                self.userWebsiteBtn.setTitle(result.userWebsite, for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        postGridView.backgroundColor = UIColor.black
        tagView.backgroundColor = UIColor.clear
        
        registerXib()
        
        // GET 요청
        MypageGET() { result in
            guard let result = result else {
                print("Failed to get data.")
                return
            }
            
            DispatchQueue.main.async {
                // Get 통해 불러온 변수 연결
                self.followerNum.setTitle("\(result.followerNum!)", for: .normal)
                self.followingNum.setTitle("\(result.followingNum!)", for: .normal)
                self.introText.text = result.userIntro
                self.userNameText.text = result.userID
                self.nameText.text = result.userName
                self.linkTitle = result.userWebsite ?? ""
                self.userWebsiteBtn.setTitle(result.userWebsite, for: .normal)
            }
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: cellName, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var introText: UILabel!
    @IBOutlet weak var userNameText: UILabel!
    @IBOutlet weak var followerNum: UIButton!
    @IBOutlet weak var followingNum: UIButton!
    @IBOutlet weak var userWebsiteBtn: UIButton!
    
    //230617 GET 요청
    func MypageGET(completion: @escaping (MyPageResponse.Result?) -> Void) {
        guard let jwt_token = TokenManager.shared.jwt else {
            completion(nil)
            return
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-ACCESS-TOKEN": jwt_token
        ]
        
        AF.request("https://umc.ljhhosting.com/api/user/profile",
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .responseDecodable(of: MyPageResponse.self) { response in
            switch response.result {
            case .success(let serverResponse):
                print(serverResponse)
                completion(serverResponse.result)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    var linkTitle = ""
    
    @IBAction func linkText(_ sender: UIButton) {
        //guard let linkButtonText = sender.title(for: .normal) else {return}
        linkTitle = sender.currentTitle!
    }
    @IBAction func ToProfileEdit(_ sender: UIButton) {
        self .performSegue(withIdentifier: "ProfileEdit", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileEdit" {
            let vc = segue.destination as! ProfileEditViewController
            vc.name = nameText.text!
            vc.userName = userNameText.text!
            vc.introduction = introText.text ?? ""
            vc.link = linkTitle
            vc.delegate = self
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
