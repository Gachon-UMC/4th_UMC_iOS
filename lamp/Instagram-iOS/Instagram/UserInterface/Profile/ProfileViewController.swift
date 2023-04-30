import UIKit

class ProfileViewController: UIViewController,EditProfileDelegate {
    
    var data_inc: [String] = ["umc_ios","가천대학교 UMC iOS","umc ios 트랙 짱","www.makeus.in/umc"]
    
    var arrImageName: [String] = ["Image1","Image2","Image3","Image4","Image5","Image6"]
    
    @IBOutlet weak var subTab: SubTabBar!
    
    @IBOutlet weak var umc_ios: UIBarButtonItem!
    @IBOutlet weak var name: UIBarButtonItem!
    @IBOutlet weak var user_name: UILabel!
    @IBOutlet weak var intro: UILabel!
    @IBOutlet weak var link: UIButton!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBAction func tap_EP(_ sender: Any) {
        
        guard let EProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileViewController else { return }
        EProfileVC.data_loaded = data_inc
        EProfileVC.delegate = self
        let navCon = UINavigationController(rootViewController: EProfileVC)
        self.present(navCon, animated: true, completion: nil)
        
        //self.navigationController?.pushViewController(EProfileVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goto_edit" {
            let EProfileVC = segue.destination as! EditProfileViewController
            EProfileVC.data_loaded = ["umc_ios","가천대학교 UMC iOS","umc ios 트랙 짱","www.makeus.in/umc"]
        }
    }
    
    func didSaveProfile(data: [String]) {
        data_inc = data
        nameDist()
        
    }
    /*
    /// EditprofileView -> profileView로 넘어오는 NotificationData Observer
    private func addNotiObserver() {
            NotificationCenter.default.addObserver(self, selector: #selector(EditConfig), name: NSNotification.Name(rawValue: pushdata_noti), object: nil)
            // self : 현재 자기자신 뷰컨에 옵저버를 달겠다.
            // selector : 해당 신호를 받으면 실행하는 함수 부분
            // name : 신호를 구분하기 위한 이름
            // object : 해당 신호를 걸러주는 필터같은 역할, nil 사용시 해당 신호를 모두 받겠다는 의미
        }
    
    /// addNotiObeserver()에 활용되는 data_inc 변경 함수
    @objc func EditConfig(notification : NSNotification){
            print("EditConfig called")
            if let data = notification.object as? [String]{
                //as? [String]는 optional한 값을 [String] 타입으로 캐스팅하는 것을 의미합니다.
                data_inc = data
                nameDist()
            }
        }
     */
    
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
        umc_ios.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold)],for: .normal)
        nameDist()
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

/*
extension SubTabBar: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            if item.tag == 0 {
                // Do something for Item 1
            } else if item.tag == 1 {
                // Do something for Item 2
            }
        }
}*/

