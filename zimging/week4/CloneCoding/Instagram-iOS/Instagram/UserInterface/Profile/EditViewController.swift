//
//  EditViewController.swift
//  Instagram
//
//  Created by YOUJIM on 2023/04/16.
//

import UIKit

protocol SendDataToProfile {
    func sendDataToP (myName: String, myID: String, myIntro: String, myLink: String)
}

class EditViewController: UIViewController, SendDataToEdit {
    func SendDataToE(myName: String, myID: String, myIntro: String, myLink: String) {
        nameText.placeholder = myName
        userNameText.placeholder = myID
        introText.placeholder = myIntro
        linkText.placeholder = myLink
    }
    
    //프로토콜로 delegate 변수 생성
    var delegate: SendDataToProfile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        nameText.borderStyle = .none
        introText.borderStyle = .none
        userNameText.borderStyle = .none
        linkText.borderStyle = .none
    }
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var introText: UITextField!
    @IBOutlet weak var linkText: UITextField!
    
    var name = ""
    var id = ""
    var intro = ""
    var link = ""
    
    func setup() {
        nameText.text = name
        userNameText.text = id
        introText.text = intro
        linkText.text = link
    }
    
    @IBAction func doneBtn(_ sender: UIButton) {
        guard let tempName = nameText.text else {return}
        guard let tempId = userNameText.text else {return}
        guard let tempIntro = introText.text else {return}
        guard let tempLink = linkText.text else {return}
        
        delegate?.sendDataToP(myName: tempName, myID: tempId, myIntro: tempIntro, myLink: tempLink)
    }
}
