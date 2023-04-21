//
//  ProfileViewController.swift
//  Instagram
//
//  Created by 서은수 on 2022/09/19.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func editBtn(_ sender: Any) {
        performSegue(withIdentifier: "goToEdit", sender: self)
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var intro: UILabel!
    @IBOutlet weak var link: UILabel!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEdit" {
            let vc = segue.destination as! ProfileEditController
            vc.name = name.text!
            vc.id = id.text!
            vc.intro = intro.text!
            vc.link = link.text!
            vc.delegate = self //이건 왜 해주는거지? 중간끝나고 봐야지......
        }
    }
    
    @IBAction func backToPage(_ sender: UIStoryboardSegue) {
    }
}
