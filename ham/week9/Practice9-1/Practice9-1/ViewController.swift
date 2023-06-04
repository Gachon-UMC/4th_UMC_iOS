//
//  ViewController.swift
//  Practice9-1
//
//  Created by 이재혁 on 2023/06/03.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAPOD()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var title_label: UILabel!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var description_label: UILabel!
    
    let APIKey = "t8uuqzSn41pMIfc4EBOqtLF9h7FJtlZ3mqgioBqr"
    let APIURL = "https://api.nasa.gov/planetary/apod?api_key="

    func fetchAPOD() {
        let request = AF.request(APIURL + APIKey)
        request.responseDecodable(of: APOD.self) { response in
            guard let apod = response.value else {return}
            
            self.loadDetails(apod: apod)
            self.loadImage(urlString: apod.url)
        }
    }
    
    func loadDetails(apod: APOD) {
        title_label.text = apod.title
        title_label.textColor = .systemGreen
        title_label.numberOfLines = 0
        title_label.font = .preferredFont(forTextStyle: .title1)
        
        description_label.text = apod.explanation
        description_label.numberOfLines = 0
        description_label.font = .preferredFont(forTextStyle: .body)
    }
    
    func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else {return}
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.Image.image = image
                    }
                }
            }
        }
    }

}


