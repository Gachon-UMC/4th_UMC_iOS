//
//  ViewController.swift
//  thirdWeekPractice
//
//  Created by 이재혁 on 2023/04/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func segueBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueShow", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueShow" {
            let vc = segue.destination as! SegueViewController
            vc.secondText = "through"
        }
    }
    
    @IBAction func modalPresent(_ sender: UIButton) {
        let newVC = self.storyboard?.instantiateViewController(identifier: "modalView")
        newVC?.modalTransitionStyle = .coverVertical
        newVC?.modalPresentationStyle = .automatic
        self.present(newVC!, animated: true, completion: nil)
    }
    
    
    @IBAction func navPush(_ sender: UIButton) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "navPush")
        self.navigationController?.pushViewController(pushVC!, animated: true)
    }
}

