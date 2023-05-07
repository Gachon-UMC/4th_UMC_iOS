//
//  ViewController.swift
//  Practice5-1
//
//  Created by 이재혁 on 2023/05/04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.myButton.addTarget(self, action: #selector(myFunc), for: .touchUpInside)
    }
    
    @objc func myFunc() {
        print("04:53AM")
    }


}

