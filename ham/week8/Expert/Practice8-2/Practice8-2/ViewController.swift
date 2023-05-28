//
//  ViewController.swift
//  Practice8-2
//
//  Created by 이재혁 on 2023/05/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func moveView(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            //원하는 위치로 myView의 frame 변경
            self.myView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
            self.view.layoutIfNeeded()
        }
    }
    
}

