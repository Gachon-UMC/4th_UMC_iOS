//
//  ViewController.swift
//  Dispatch_Practice
//
//  Created by 박민서 on 2023/05/10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var load: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYrsw9JzIfowXR93ZhrOPoMdrRov79v43QwQ&usqp=CAU") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            guard data != nil else {return}
            
            DispatchQueue.main.async {
                self?.view.backgroundColor = .gray
                self?.load.isHidden = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {

                if let image = UIImage(data: data!) {
                self?.ImageView.image = image
                self?.load.isHidden = true
                }
            }
            
            
            
            
            
        })
        
        task.resume()
    }
}

