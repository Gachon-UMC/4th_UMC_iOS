//
//  ViewController.swift
//  Practice_3
//
//  Created by YOUJIM on 2023/05/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var jokeBearView: UIImageView!
    
    var tapGesture: UITapGestureRecognizer!
    
    let sadBear = UIImage(named: "sadBear")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        jokeBearView.isUserInteractionEnabled = true
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        jokeBearView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.6, delay: 0.0, options: [.curveLinear], animations: {
            self.jokeBearView.transform = self.jokeBearView.transform.rotated(by: .pi)
            self.jokeBearView.transform = self.jokeBearView.transform.rotated(by: .pi)
        }) { _ in
            self.jokeBearView.image = self.sadBear
        }
    }
}


