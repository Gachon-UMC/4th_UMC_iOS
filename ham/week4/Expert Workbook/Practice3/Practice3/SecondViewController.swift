//
//  SecondViewController.swift
//  Practice3
//
//  Created by 이재혁 on 2023/04/29.
//

import UIKit

protocol ChangeUIDelegate: AnyObject {
    func changeUI()
}

class SecondViewController: UIViewController {
    
    weak var delegate: ChangeUIDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickButton(_ sender: Any) {
        self.delegate?.changeUI()
        self.dismiss(animated: true, completion: nil)
    }
    
}
