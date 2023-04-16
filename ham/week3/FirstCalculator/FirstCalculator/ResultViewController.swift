//
//  ResultViewController.swift
//  FirstCalculator
//
//  Created by 이재혁 on 2023/04/16.
//

import UIKit

class ResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = resultText

        // Do any additional setup after loading the view.
    }
    
    var resultText = ""
    
    @IBOutlet weak var resultLabel: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
