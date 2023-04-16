//
//  ProfileViewController.swift
//  Instagram
//
//  Created by 서은수 on 2022/09/19.
//

import UIKit

class ProfileViewController: UIViewController, SendStringData {
    func sendData(mydata: String, myUserName: String, myIntro: String) {
        nameText.text = mydata
        userNameText.text = myUserName
        introText.text = myIntro
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var introText: UILabel!
    @IBOutlet weak var userNameText: UILabel!
    
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
            vc.introduction = introText.text!
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
