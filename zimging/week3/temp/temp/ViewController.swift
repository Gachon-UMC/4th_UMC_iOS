//
//  ViewController.swift
//  temp
//
//  Created by YOUJIM on 2023/04/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func nextBtn(_ sender: Any) { guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController else { return }
        nextVC.data = "Hello B화면"
        nextVC.AVC = self self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}

