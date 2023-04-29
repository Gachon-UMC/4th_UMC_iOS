//
//  ReceiverVC.swift
//  Train_Delegate
//
//  Created by YOUJIM on 2023/04/27.
//

import UIKit

class ReceiverVC : UIViewController, SendData {
    
    var tempText = ""
    @IBOutlet weak var displayText: UILabel!
    
    func setUp() {
        displayText.text = tempText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func dataSend(data: String) {
    }
    
}
