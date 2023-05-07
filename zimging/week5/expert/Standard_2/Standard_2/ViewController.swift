//
//  ViewController.swift
//  Standard_2
//
//  Created by YOUJIM on 2023/05/04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loadLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setProgress() {
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 10
        progressView.subviews[1].clipsToBounds = true
        
    }
    


}

