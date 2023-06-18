import UIKit

///완료 시 ProfileViewController의 데이터 로딩을 위한 delegate protocol입니다.
protocol EditProfileDelegate {
    func LoadDataFromServer(_ completion: @escaping () -> Void)
}

class EditProfileViewController: UIViewController {
    
    var delegate: EditProfileDelegate? // 완료 시 ProfileViewController의 데이터 로딩을 위한 delegate

    @IBOutlet weak var photo_view: UIView!
    @IBOutlet weak var info_view: UIView!
    @IBOutlet weak var tap1_view: UIView!
    @IBOutlet weak var tap2_view: UIView!
    @IBOutlet weak var tap3_view: UIView!
    
    @IBOutlet weak var name_text: UITextField!
    @IBOutlet weak var user_text: UITextField!
    @IBOutlet weak var intro_text: UITextField!
    @IBOutlet weak var link_text: UITextField!
    
    var data: [String] = ["","","",""]
    var data_loaded: [String]?
    
    @IBAction func tap_cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func tap_insert(_ sender: Any) {
        guard let nameText = name_text.text else {return}
        guard let userNameText = user_text.text else {return}
        guard let introText = intro_text.text else {return}
        guard let linkText = link_text.text else {return}
        
        /// 유저 정보 PATCH하는 함수를 호출합니다.
        /// 이후 문제가 없다면 전 화면의 데이터를 서버에서 다시 불러온 후, 본 화면을 dismiss합니다.
        APIManger.shared.PATCH_UserMod(userName: userNameText, userId: nameText, userIntro: introText, userWebsite: linkText) { isSuccess in
            if isSuccess {
                self.delegate?.LoadDataFromServer {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
    private func dataDist() {
        //print("dataDist Called")
        name_text.text = data[0]
        user_text.text = data[1]
        intro_text.text = data[2]
        link_text.text = data[3]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        if let data_inc = data_loaded {
            data = data_inc
            dataDist()
        }
        
        self.navigationController?.navigationBar.layer.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0)

        photo_view.layer.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0)
        info_view.layer.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0)
        tap1_view.layer.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0)
        tap2_view.layer.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0)
        name_text.layer.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0, set: "textfield")
        user_text.layer.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0, set: "textfield")
        intro_text.layer.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0, set: "textfield")

    }
    
    
    
}
