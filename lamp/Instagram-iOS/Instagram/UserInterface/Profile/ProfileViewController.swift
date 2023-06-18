import UIKit

@available(iOS 16.0, *)
class ProfileViewController: UIViewController,EditProfileDelegate {
    
    var data_inc: [String] = ["umc_ios","가천대학교 UMC iOS","umc ios 트랙 짱","www.makeus.in/umc"]
    
    var arrImageName: [String] = ["Image1","Image2","Image3","Image4","Image5","Image6"]
    
    @IBOutlet weak var subTab: SubTabBar!

    @IBOutlet weak var name: UIBarButtonItem!
    @IBOutlet weak var user_name: UILabel!
    @IBOutlet weak var intro: UILabel!
    @IBOutlet weak var link: UIButton!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var postNum: UILabel!
    @IBOutlet weak var followerNum: UILabel!
    @IBOutlet weak var followingNum: UILabel!
    
    @IBAction func tap_EP(_ sender: Any) {
        
        guard let EProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileViewController else { return }
        EProfileVC.data_loaded = data_inc   // 본 VC의 프로필데이터를 EProfileVC의 데이터로 넘겨줍니다.
        EProfileVC.delegate = self
        let navCon = UINavigationController(rootViewController: EProfileVC)
        self.present(navCon, animated: true, completion: nil)
    }
    
    @IBAction func tap_AddPost(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Sheet", bundle: nil)
        let sheetPresentationController = storyboard.instantiateViewController(withIdentifier: "SheetViewController") as! SheetViewController
        sheetPresentationController.Option = "AddPost"
        self.present(sheetPresentationController, animated: true, completion: nil)
    }
    
    @IBAction func tap_AddOption(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Sheet", bundle: nil)
        let sheetPresentationController = storyboard.instantiateViewController(withIdentifier: "SheetViewController") as! SheetViewController
        sheetPresentationController.Option = "Option"
        self.present(sheetPresentationController, animated: true, completion: nil)
    }
    
    /// data_inc의 요소값듫을 ui요소에 배정
    private func nameDist() {
        name.title = data_inc[0]
        user_name.text = data_inc[1]
        intro.text = data_inc[2]
        link.setTitle(data_inc[3], for: .normal)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //SubTabBar = UITabBar()
        name.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold)],for: .normal)
        name.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold)],for: .highlighted)
        //프로필 데이터 불러오기
        LoadDataFromServer() {}
        
    }
    
    /// 유저의 프로필 데이터를 불러오는 함수입니다.
    func LoadDataFromServer(_ completion: @escaping () -> Void) {
        APIManger.shared.GET_Profile{ result in
            self.data_inc[0] = result?.userID ?? ""
            self.data_inc[1] = result?.userName ?? ""
            self.data_inc[2] = result?.userIntro ?? ""
            self.data_inc[3] = result?.userWebsite ?? ""
            self.postNum.text = String(result?.postNum ?? 0)
            self.followerNum.text = String(result?.followerNum ?? 0)
            self.followingNum.text = String(result?.followingNum ?? 0)
            self.user_name.font = UIFont.systemFont(ofSize: 16)
            self.intro.font = UIFont.systemFont(ofSize: 15)
            self.link.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            self.nameDist() //self.data_inc의 배열값을 토대로 UI요소에 값을 저장해줍니다.
            completion()
        }
    }
    

}

@available(iOS 16.0, *)
extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // CollectionView item 개수
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrImageName.count
        }
        
        // CollectionView Cell의 Object
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCollectionViewCell", for: indexPath) as! GridCollectionViewCell
            
            cell.image.image = UIImage(named: arrImageName[indexPath.row]) ?? UIImage()
            
            return cell
        }
        
        // CollectionView Cell의 Size
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let width: CGFloat = collectionView.frame.width / 3 - 1.0
            
            return CGSize(width: width, height: width)
        }
        
        // CollectionView Cell의 위아래 간격
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 1.0
        }
        
        // CollectionView Cell의 옆 간격
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1.0
        }
}


