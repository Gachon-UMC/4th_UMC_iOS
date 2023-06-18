//
//  ViewController.swift
//  Standard_3
//
//  Created by YOUJIM on 2023/06/09.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var translateBtn: UIButton!
    @IBOutlet weak var translatedLabel: UILabel!
    
    let baseURL = "https://openapi.naver.com/v1/papago/n2mt"
    let clientID = "BdcOiw3sSy_MjAFcNVSH"
    let clientSecret = "DNfHysneFw"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func translateButtonTapped(_ sender: Any) {
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        
        let sourceLang = "ko"  // 원본 언어 코드
        let targetLang = "en"  // 번역할 언어 코드
        
        guard let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        let urlString = "\(baseURL)?source=\(sourceLang)&target=\(targetLang)&text=\(encodedText)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        request.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching translation: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TranslationResponse.self, from: data)
                let translatedText = response.message.result.translatedText
                DispatchQueue.main.async {
                    self?.translatedLabel.text = translatedText
                }
            } catch {
                print("Error decoding translation response: \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct TranslationResponse: Codable {
    let message: TranslationMessage
}

struct TranslationMessage: Codable {
    let type, service, version: String
        let result: TranslationResult

        enum CodingKeys: String, CodingKey {
            case type = "@type"
            case service = "@service"
            case version = "@version"
            case result
        }
}

struct TranslationResult: Codable {
    let srcLangType, tarLangType, translatedText: String
}

