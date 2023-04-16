//
//  SwiftUIView.swift
//  temp
//
//  Created by YOUJIM on 2023/04/16.
//

import UIKit

class SecondViewController : UIViewController {
    var data : String = ""; var AVC : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataLabel.text = data
                guard let beforeVC = AVC as? AViewController else { return }
                beforeVC.check(str: "nice 2 meet u")
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
