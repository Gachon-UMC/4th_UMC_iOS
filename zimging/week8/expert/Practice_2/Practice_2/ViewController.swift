//
//  ViewController.swift
//  Practice_2
//
//  Created by YOUJIM on 2023/05/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var clickToMoveLabel: UILabel!
    @IBOutlet weak var clickToMoveBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func clickToMove(_ sender: Any) {
        UIView.animate(withDuration: 5.0, delay: 1.0, options: [], animations: {
            self.clickToMoveLabel.frame.origin = CGPoint(x: self.clickToMoveLabel.frame.origin.x, y: self.view.bounds.height - self.clickToMoveLabel.frame.size.height)
            self.view.layoutIfNeeded()
        })
    }
}

