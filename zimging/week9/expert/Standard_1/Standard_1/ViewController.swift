//
//  ViewController.swift
//  Standard_1
//
//  Created by YOUJIM on 2023/06/09.
//

import UIKit
import Foundation


class ViewController: UIViewController {
    
    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var requestBtn: UIButton!
    @IBOutlet weak var responseLabel: UILabel!
    
    let apiKey = "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"
    let endpoint = "https://api.openai.com/v1/chat/completions"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func requestAction(_ sender: Any) {
        guard let question = questionField.text, !question.isEmpty else {
            return
        }
        
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        let data = [
            "model": "gpt-3.5-turbo",
            "messages": [["role": "user", "content": question]]
        ] as [String : Any]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []) else {
            return
        }
        
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let responseData = data, error == nil else {
                print("Error calling ChatGPT API: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                if let choices = responseJSON?["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    DispatchQueue.main.async {
                        self?.responseLabel.text = content
                    }
                }
            } catch {
                print("Error parsing API response: \(error)")
            }
        }
        
        task.resume()
    }
}

