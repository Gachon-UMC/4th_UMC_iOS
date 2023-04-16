//
//  ViewController.swift
//  Train_data_1
//
//  Created by YOUJIM on 2023/04/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func nextBtn(_ sender: Any) {
        performSegue(withIdentifier: "goToSecond", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecond" {
            let vc = segue.destination as! SecondViewController
            vc.secondText = "data"
        }
    }
    
}

