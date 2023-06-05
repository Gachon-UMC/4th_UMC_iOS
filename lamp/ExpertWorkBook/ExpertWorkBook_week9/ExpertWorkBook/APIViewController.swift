//
//  APIViewController.swift
//  ExpertWorkBook
//
//  Created by 박민서 on 2023/06/02.
//

import Foundation
import Alamofire
import AlamofireImage

class APIViewController: UIViewController {
    @IBOutlet weak var title_label: UILabel!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var description_label: UILabel!
    
    //Alamofire()
    
    //MarsWeather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Image.layer.cornerRadius = 0.5
         APOD()
        print("+++++++++++++")
        tax()
        
    }
    
    func APOD() {
        let url = "https://api.nasa.gov/planetary/apod"
        let parameters: Parameters = [
            "api_key":"dVZ5i5vd3QeAEjbhoGHLSeyrVWIgn431hMClpLmR",
            "count": "1"
        ]
        
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let valArr = value as? [[String: Any]] {
                        for valDict in valArr {
                            if let title = valDict["title"] as? String {
                               //print("title: \(title)")
                                self.title_label.text = title
                            }
                            if let date = valDict["date"] as? String {
                                //print("Date: \(date)")
                            }
                            if let explanation = valDict["explanation"] as? String {
                                //print("Explanation: \(explanation)")
                                self.description_label.text = explanation
                                self.description_label.textAlignment = .natural
                            }
                            if let url = valDict["url"] as? String {
                                //print("url: \(url)")
                                // URL 생성
                                       if let imageURL = URL(string: url) {
                                           
                                           // 이미지 요청
                                           AF.request(imageURL).responseImage { response in
                                               
                                               // 응답 처리
                                               if case .success(let image) = response.result {
                                                   // 이미지를 받아온 경우, 이미지뷰에 설정
                                                   self.Image.image = image
                                               }
                                           }
                                       }
                            }
                        }
                    }

                    // 성공적인 응답을 처리하는 로직
                    //print(value)
                case .failure(let error):
                    // 에러를 처리하는 로직
                    print(error)
                }
            
            }
    }

}

func tax() {
    let url = "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=VMJCF2dz8Wj0qbUO6b7z68oQGM7VzBD88NUGC9mtMCZQl0MMFkctR9njZbw7FWB%2FOhiyD4eiy%2FoPG%2F7Mhkazyw%3D%3D"
        
    //"http://api.odcloud.kr/api/nts-businessman/v1/validate?serviceKey=VMJCF2dz8Wj0qbUO6b7z68oQGM7VzBD88NUGC9mtMCZQl0MMFkctR9njZbw7FWB%2FOhiyD4eiy%2FoPG%2F7Mhkazyw%3D%3D"

    let parameters: [String: Any] = [
        "b_no": ["2208162517"]
    ]
    
    AF.request(url, method: .post, parameters: parameters).validate().responseJSON { response in
        switch response.result {
        case .success(let value):
            print(value)
        
        case .failure(let error):
            print(error)
        }
    }
}



