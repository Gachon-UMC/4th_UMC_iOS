//
//  ViewController.swift
//  FirstCalculator
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
            let vc = segue.destination as! ResultViewController
            vc.resultText = String(sum)
        }
    }
    
    @IBOutlet weak var display: UILabel!
    
    var isPlus = false;
    var isMinus = false;
    var isCross = false;
    var isDiv = false;
    
    var sum = Int()
    var num = Int()
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit: String = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display!.text!
            display!.text = textCurrentlyInDisplay + digit
        } else {
            display!.text = digit
        }
        userIsInTheMiddleOfTyping = true
        
    }
    
    @IBAction func clear(_ sender: Any) {
        display.text = "0"
        sum = 0
        num = 0
    }
    @IBAction func plus(_ sender: Any) {
        if isPlus == false {
            num = Int(display.text!)!
            print("num", num)
            sum = num + sum
            print("sum", sum)
            userIsInTheMiddleOfTyping = false
            isPlus = true
        }
    }
    @IBAction func minus(_ sender: Any) {
        if isMinus == false {
            num = Int(display.text!)!
            print("num",num)
            sum = num + sum
            print("sum",sum)
            userIsInTheMiddleOfTyping = false
            isMinus = true
        }
    }
    @IBAction func cross(_ sender: Any) {
        if isCross==false {
            num = Int(display.text!)!
            print("num",num)
            sum = num + sum
            print("sum",sum)
            userIsInTheMiddleOfTyping = false
            isCross = true
        }
    }
    @IBAction func div(_ sender: Any) {
        if isDiv==false {
            num = Int(display.text!)!
            print("num",num)
            sum = num + sum
            print("sum",sum)
            userIsInTheMiddleOfTyping = false
            isDiv = true
        }
    }
    @IBAction func result(_ sender: Any) {
        if isPlus{
            sum  = sum + Int(display.text!)!
            print("result Plus", sum)
            isPlus = false
            display.text = String(sum)
        }
                
        if isMinus {
            sum  = sum - Int(display.text!)!
            print("result Minus", sum)
            isMinus = false
            display.text = String(sum)
        }
               
        if isCross {
            sum  = sum * Int(display.text!)!
            print("result Cross", sum)
            isCross = false
            display.text = String(sum)
        }
                
        if isDiv {
            sum  = sum / Int(display.text!)!
            print("result Div", sum)
            isDiv = false
            display.text = String(sum)
        }
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
}

