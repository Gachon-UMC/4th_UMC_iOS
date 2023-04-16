//
//  ViewController.swift
//  Standard_Calculator
//
//  Created by YOUJIM on 2023/04/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var data: UILabel?
    var status: Bool = false //0이면 연산 버튼 누르기 전
    var method: String = ""
    var var1 : Int = 0
    var var2 : Int = 0
    
    @IBAction func num1(_ sender: UIButton) {
        let digit = "1"
        let currentDisplay = data!.text!
        data!.text = currentDisplay + digit
    }
    @IBAction func num2(_ sender: UIButton) {
        let digit = "2"
        let currentDisplay = data!.text!
        data!.text = currentDisplay + digit
    }
    @IBAction func num3(_ sender: UIButton) {
        let digit = "3"
        let currentDisplay = data!.text!
        data!.text = currentDisplay + digit
    }
    @IBAction func num4(_ sender: UIButton) {
        let digit = "4"
        let currentDisplay = data!.text!
        data!.text = currentDisplay + digit
    }
    @IBAction func num5(_ sender: UIButton) {
        let digit = "5"
        let currentDisplay = data!.text!
        data!.text = currentDisplay + digit
    }
    @IBAction func num6(_ sender: UIButton) {
        let digit = "6"
        let currentDisplay = data!.text!
        data!.text = currentDisplay + digit
    }
    @IBAction func num7(_ sender: UIButton) {
        let digit = "7"
        let currentDisplay = data!.text!
        data!.text = currentDisplay + digit
    }
    @IBAction func num8(_ sender: UIButton) {
        let digit = "8"
        let currentDisplay = data!.text!
        data!.text = currentDisplay + digit
    }
    @IBAction func num9(_ sender: UIButton) {
        let digit = "9"
        let currentDisplay = data!.text!
        data!.text = currentDisplay + digit
    }
    
    @IBAction func num0(_ sender: Any) {
        let digit = "0"
        let currentDisplay = data!.text!
        data!.text = currentDisplay + digit
    }
    
    
    @IBAction func divideBtn(_ sender: Any) {
        if status == false {
            status = true
            var1 = Int(data!.text!)!
            data!.text = ""
            method = "divide"
        }
    }
    
    @IBAction func mtpBtn(_ sender: Any) {
        if status == false {
            status = true
            var1 = Int(data!.text!)!
            data!.text = ""
            method = "multiple"
        }
    }
    
    
    @IBAction func minusBtn(_ sender: Any) {
        if status == false {
            status = true
            var1 = Int(data!.text!)!
            data!.text = ""
            method = "minus"
        }
    }
    
    @IBAction func plusBtn(_ sender: Any) {
        if status == false {
            status = true
            var1 = Int(data!.text!)!
            data!.text = ""
            method = "plus"
        }
    }
    
    @IBAction func resultBtn(_ sender: Any) {
        if status == true {
            if method == "plus" {
                var2 = Int(data!.text!)!
                data!.text = "\(var1 + var2)"
            }
            else if method == "minus" {
                var2 = Int(data!.text!)!
                data!.text = "\(var1 - var2)"
            }
            else if method == "multiple" {
                var2 = Int(data!.text!)!
                data!.text = "\(var1 * var2)"
            }
            else if method == "divide" {
                var2 = Int(data!.text!)!
                data!.text = "\(var1 / var2)"
            }
        }
    }
}

