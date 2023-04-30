import UIKit

protocol EditProfileDelegate {
    func didSaveProfile(data: [String])
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat, set: String = "Normal") {
        for edge in arr_edge {
            let border = CALayer()
            border.name = name ?? edge.rawValue.description
            switch edge {
                        case UIRectEdge.top:
                            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                            break
                        case UIRectEdge.bottom:
                            if set == "Normal" {
                                    border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                            } else if set == "textfield" {
                                border.frame = CGRect.init(x: 0, y: frame.height - width + 10, width: self.bounds.width - 20, height: width)
                                //print("조정된?",self.bounds.width)
                                //print("원본",frame.width)
                            }
                            break
                        case UIRectEdge.left:
                            border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                            break
                        case UIRectEdge.right:
                            border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                            break
                        default:
                            break
                        }
            border.backgroundColor = color.cgColor;
                        self.addSublayer(border)
        }
    }
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat, name: String) {
        for edge in arr_edge {
            let border = CALayer()
            border.name = name //?? edge.rawValue.description
            switch edge {
                        case UIRectEdge.top:
                            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                            break
                        case UIRectEdge.bottom:
                            if name == "firstBorder" {
                                    border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width/2, height: width)
                            } else if name == "secondBorder" {
                                border.frame = CGRect.init(x: frame.width/2, y: frame.height - width, width: self.bounds.width - 20, height: width)
                                //print("조정된?",self.bounds.width)
                                //print("원본",frame.width)
                            }
                            break
                        case UIRectEdge.left:
                            border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                            break
                        case UIRectEdge.right:
                            border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                            break
                        default:
                            break
                        }
            border.backgroundColor = color.cgColor;
                        self.addSublayer(border)
        }
    }
}

class EditProfileViewController: UIViewController {
    
    var delegate: EditProfileDelegate?

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
    
        data[0] = nameText
        data[1] = userNameText
        data[2] = introText
        data[3] = linkText
        
        self.delegate?.didSaveProfile(data: data)
        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
                
        
    }
    
    /*
    /// profileView -> EditprofileView로 넘어오는 NotificationData Observer
    private func addNotiObserver_Edit() {
        print("addNotiObserver_Edit called")
        NotificationCenter.default.addObserver(self, selector: #selector(loadData_FromProfile), name: NSNotification.Name(rawValue: pushdata_noti), object: nil)
    }
    
    @objc func loadData_FromProfile(notification : NSNotification) {
        print("loadData called")
        if let data_inc = notification.object as? [String]{
            data = data_inc
            dataDist()
            print(data)
        }
    }
     */
    
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
