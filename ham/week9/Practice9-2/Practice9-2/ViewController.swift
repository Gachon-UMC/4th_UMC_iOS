//
//  ViewController.swift
//  Practice9-2
//
//  Created by 이재혁 on 2023/06/03.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    var inputText: String = ""
    
    @IBAction func editEnd(_ sender: Any) {
        
    }
    @IBAction func buttonTapped(_ sender: Any) {
        inputText = inputTextField.text!
        myZZAZZAGO()
    }
    
    func myZZAZZAGO() {
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
            "X-Naver-Client-Id": "m5fIU8VO3K70iNQ8E5i8",
            "X-Naver-Client-Secret": "QNJj55QrYp"
        ]
        
        let parameters: Parameters = [
            "source": "ko",
            "target": "en",
            "text": self.inputText
        ]
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        print(self.inputText)
        
        AF.request(url, method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: headers)
        .responseDecodable(of: top.self) { response in
            self.outputLabel.text = response.value?.message.result.translatedText
            print(response.value?.message.result.translatedText)
        }
    }
    
}

