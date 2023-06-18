//
//  ViewController.swift
//  Practice9-3
//
//  Created by 이재혁 on 2023/06/09.
//

import UIKit
//import Alamofire

class ViewController: UIViewController {
    var inputText = ""
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputTextLabel: UILabel!
    @IBAction func buttonTapped(_ sender: Any) {
        inputText = inputTextField.text!
        myGPT(input: inputText) { response in
            self.outputTextLabel.text = response
        }
    }
    @IBAction func editDidEnd(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func myGPT(input: String, completion: @escaping (String) -> Void) {
        let json: [String: Any] = ["prompt": input,
                                   "max_tokens": 60]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/engines/text-davinci-003/completions")!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error!)")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                if let choices = responseJSON["choices"] as? [[String: Any]],
                   let firstChoice = choices.first,
                   let text = firstChoice["text"] as? String {
                    DispatchQueue.main.async {
                        completion(text)
                    }
                }
            }
        }
        
        task.resume()
    }
//    func myGPT() {
//        let json: [String: Any] = ["prompt": inputText,
//                                   "max_tokens": 60]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//
//        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/engines/davinci-codex/completions")!)
//        request.httpMethod = "POST"
//        request.httpBody = jsonData
//        request.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error: \(error!)")
//                return
//            }
//
//            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//            if let responseJSON = responseJSON as? [String: Any] {
//                print(responseJSON)
//            }
//        }
//
//        task.resume()
//    }

}


