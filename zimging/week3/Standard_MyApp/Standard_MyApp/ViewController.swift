//
//  ViewController.swift
//  Standard_MyApp
//
//  Created by YOUJIM on 2023/04/16.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var text: UILabel!
    
    @IBAction func homeworkBtn(_ sender: Any) {
        performSegue(withIdentifier: "goToHomework", sender: sender)
    }
    
    @IBAction func backToHome(_ sender: UIStoryboardSegue) {
        }
    
}

