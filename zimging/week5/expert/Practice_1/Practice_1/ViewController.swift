//
//  ViewController.swift
//  Practice_1
//
//  Created by YOUJIM on 2023/05/03.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myButton.addTarget(self, action: #selector(myFunc), for: .touchUpInside)
    }
    
    @objc func myFunc() {
        print("와 된다!")
    }


}

