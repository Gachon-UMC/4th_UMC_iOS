//
//  ViewController.swift
//  Practice_2
//
//  Created by YOUJIM on 2023/05/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dogButton(_ sender: Any) {
        DispatchQueue.global().sync {
            var dogStr = "🐶🐶🐶🐶🐶"
            Thread.sleep(forTimeInterval: 3)
            label.text = dogStr
        }
    }
    
    @IBAction func catButton(_ sender: Any) {
        DispatchQueue.global().sync {
            var catStr = "😻😻😻😻😻"
            Thread.sleep(forTimeInterval: 3)
            label.text = catStr
            print(catStr)
        }
    }

    
    @IBAction func hamButton(_ sender: Any) {
        DispatchQueue.global().sync {
            var hamStr = "🐹🐹🐹🐹🐹"
            Thread.sleep(forTimeInterval: 3)
            label.text = hamStr
        }
    }
}

