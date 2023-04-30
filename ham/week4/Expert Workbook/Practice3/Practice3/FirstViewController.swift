//
//  ViewController.swift
//  Practice3
//
//  Created by 이재혁 on 2023/04/29.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {return}
        
        vc.modalTransitionStyle = .coverVertical
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension FirstViewController: ChangeUIDelegate {
    func changeUI() {
        self.textLabel.text = "UI가 변경됨"
        self.view.backgroundColor = .systemTeal
    }
}

