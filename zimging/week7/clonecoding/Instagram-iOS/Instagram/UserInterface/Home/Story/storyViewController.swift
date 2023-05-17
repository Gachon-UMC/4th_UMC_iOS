//
//  storyViewController.swift
//  Instagram
//
//  Created by YOUJIM on 2023/05/18.
//

import UIKit

class storyViewController : UIViewController {
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var dmField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        profileButton?.layer.cornerRadius = 0.5 * profileButton.bounds.size.width
//
//        dmField?.layer.borderWidth = 0.5
//        dmField?.layer.borderColor = UIColor.lightGray.cgColor
    }
}
