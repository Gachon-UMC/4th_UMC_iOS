//
//  PAPAandCOCK.swift
//  ExpertWorkBook
//
//  Created by 박민서 on 2023/06/03.
//

import Foundation
import UIKit
import Alamofire

class PapagoAndCocktailViewController: UIViewController {
    
    @IBOutlet weak var PAPAGO_INPUT_TEXT: UITextField!
    @IBOutlet weak var PAPAGO_OUT_TEXT: UITextField!
    
    @IBAction func PAPAGOInputEnd(_ sender: Any) {
        print("??")
    }
    
    @IBAction func Translate(_ sender: Any) {
        if let validText = self.PAPAGO_INPUT_TEXT.text {
            PAPAGO(text:validText) { ResultText in
                self.PAPAGO_OUT_TEXT.text = ResultText
            }
        } else {
            print("PAPAGO INPUT 재입력")
        }
    }
    
    
    @IBOutlet weak var CocktailName: UITextField!
    @IBOutlet weak var CocktailTView: UITextView!
    @IBAction func CockINPUTEnd(_ sender: Any) {
    }
    
    @IBAction func FindCocktal(_ sender: Any) {
        if let validText = self.CocktailName.text {
            getctail(text: validText) { outputText in
                self.CocktailTView.text = outputText
            }
        } else {
            print("Cokctail INPUT 재입력")
        }
    }
    
    override func viewDidLoad() {
        CocktailTView.textContainer.maximumNumberOfLines = 0 // 여러 줄로 나뉘도록 설정
        CocktailTView.textContainer.lineBreakMode = .byWordWrapping // 단어 단위로 줄이 나뉘도록 설정
    }
}


struct Cocktails: Decodable {
    let drinks: [drink]
}

struct drink: Decodable {
    let idDrink: String?
    let strDrink: String
    let strCategory: String?
    let strInstructions: String?
    let strImageSource: String?
}

func getctail(text:String, completion: @escaping (String) -> Void) {
    let url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(text)"
    
    var outputText = ""
    
    AF.request(url).responseDecodable(of: Cocktails.self) { response in
        switch response.result{
        case .success(let data):
            for drinkname in data.drinks {
//                print("name : ",drinkname.strDrink)
//                print("strInstruction : ", drinkname.strInstructions ?? "None" )
                
                outputText.append("name : \(drinkname.strDrink)\n")
                outputText.append("strInstruction : \(drinkname.strInstructions ?? "None")\n\n")
                completion(outputText)
            }
        case .failure(let error):
            outputText = "\(error)"
            completion(outputText)
        }
    }
}



struct TranslationResponse: Decodable {
    let message: Message
}

struct Message: Decodable {
    let result: Result
}

struct Result: Decodable {
    let srcLangType: String
    let tarLangType: String
    let translatedText: String
}


func PAPAGO(text: String, completion: @escaping (String) -> Void) {
    let url = "https://openapi.naver.com/v1/papago/n2mt"
    
    let headers: HTTPHeaders = [
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
        "X-Naver-Client-Id": "8Xj92TWtpl_E7JpSfwdJ",
        "X-Naver-Client-Secret": "B7L0heNwpl"
    ]

    let parameters: Parameters = [
        "source": "ko",
        "target": "en",
        "text": text
    ]
    
    AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        .responseDecodable(of: TranslationResponse.self) { response in
            switch response.result {
            case .success(let data):
                print(data.message.result.translatedText)
                let ResultText = data.message.result.translatedText
                completion(ResultText)
            case .failure(let error):
                // 에러를 처리하는 로직
                completion("\(error)")
            }
        }
}

