//
//  ProfileViewController.swift
//  Instagram
//
//  Created by 서은수 on 2022/09/19.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func editBtn(_ sender: Any) {
        performSegue(withIdentifier: "goToEdit", sender: sender)
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var intro: UILabel!
    @IBOutlet weak var link: UILabel!
    
    @IBAction func backToPage(_ sender: UIStoryboardSegue) {
        
    }
}
