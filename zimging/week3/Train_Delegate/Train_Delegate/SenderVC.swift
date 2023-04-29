//
//  ViewController.swift
//  Train_Delegate
//
//  Created by YOUJIM on 2023/04/27.
//

import UIKit

protocol SendData {
    func dataSend(data: String)
}

class SenderVC: UIViewController {

    var delegate : SendData?
    @IBOutlet weak var value: UITextField! // textfield 변수 설정
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendBtn(_ sender: Any) {
        performSegue(withIdentifier: "sendData", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendData"{
            let receiverVC = segue.destination as! ReceiverVC
            receiverVC.tempText = value.text!
        }
    }
}

