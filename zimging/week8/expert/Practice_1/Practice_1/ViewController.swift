//
//  ViewController.swift
//  Practice_1
//
//  Created by YOUJIM on 2023/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var endOfHellBtn: UIButton!
    @IBOutlet weak var endOfHellLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func endOfHell(_ sender: Any) {
        UIView.animate(withDuration: 1, animations: {
            self.endOfHellLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse], animations: {
                self.endOfHellLabel.alpha = 0.0
            }, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.endOfHellLabel.layer.removeAllAnimations()
            }
        }
    }
}

