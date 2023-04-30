//
//  ProfileEditViewController.swift
//  Instagram
//
//  Created by 이재혁 on 2023/04/16.
//

import UIKit

protocol SendStringData {
    func sendData(mydata: String, myUserName: String, myIntro: String)
}


class ProfileEditViewController: UIViewController {

    var dataFromFirst: String = ""
    // protocol 변수 생성
    var delegate: SendStringData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    var name = ""
    var userName = ""
    var introduction = ""
    var link = ""

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func completeTapped(_ sender: UIButton) {
        guard let nameText = nameField.text else {return}
        guard let userNameText = userNameField.text else {return}
        guard let introText = introField.text else {return}
        
        delegate?.sendData(mydata: "\(nameText)", myUserName: "\(userNameText)", myIntro: "\(introText)")
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var linkField: UITextField!
    @IBOutlet weak var introField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    
    func setup() {
//        nameField.placeholder = name
//        userNameField.placeholder = userName
//        introField.placeholder = introduction
//        linkField.placeholder = link
        nameField.text = name
        userNameField.text = userName
        introField.text = introduction
        linkField.placeholder = "링크 추가"
    }
}
