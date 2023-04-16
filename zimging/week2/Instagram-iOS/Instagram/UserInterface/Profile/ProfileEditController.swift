//
//  ProfileEdit.swift
//  Instagram
//
//  Created by YOUJIM on 2023/04/16.
//

import UIKit

class ProfileEditController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var introText: UITextField!
    @IBOutlet weak var linkText: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backProfile" {
            let vc = segue.destination as! ProfileViewController
            vc.name.text = nameText.text!
            vc.id.text = userNameText.text!
            vc.intro.text = introText.text!
            vc.link.text = linkText.text! }
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        
    }
}
