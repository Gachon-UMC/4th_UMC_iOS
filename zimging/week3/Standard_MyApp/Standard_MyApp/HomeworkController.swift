//
//  HomeworkController.swift
//  Standard_MyApp
//
//  Created by YOUJIM on 2023/04/16.
//
import UIKit

class HomeworkContoller: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToHome" {
            let homepage = segue.destination as! ViewController
            homepage.text.text = "축하해! 이제 놀아"
        }
    }
    
    @IBAction func finishBtn(_ sender: Any) {
        performSegue(withIdentifier: "backToHome", sender: sender)
    }
}
