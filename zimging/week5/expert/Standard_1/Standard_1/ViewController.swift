//
//  ViewController.swift
//  Standard_1
//
//  Created by YOUJIM on 2023/05/04.
//

import UIKit
import DynamicColor

class ViewController: UIViewController {
    
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func btnAction(_ sender: Any) {
        button.backgroundColor = DynamicColor(hexString: "c0392b").inverted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.backgroundColor = DynamicColor(hexString: "c0392b")
        // Do any additional setup after loading the view.
    }
    
    


}

