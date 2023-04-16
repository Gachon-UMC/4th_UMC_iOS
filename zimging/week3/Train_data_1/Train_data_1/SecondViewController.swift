//
//  SecondViewController.swift
//  Train_data_1
//
//  Created by YOUJIM on 2023/04/16.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var secondLabel: UILabel!
    
    var secondText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        secondLabel.text = secondText
    }

}
