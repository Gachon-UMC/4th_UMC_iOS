//
//  ViewController.swift
//  Practice5-4
//
//  Created by 이재혁 on 2023/05/04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var btn: UIButton!
    var isRed = false
    var progressBarTimer: Timer!
    var isRunning = false
    
    @IBAction func btnStart(_ sender: Any) {
        if(isRunning) {
            progressBarTimer.invalidate()
            btn.setTitle("Start", for: .normal)
        }
        else{
                btn.setTitle("Stop", for: .normal)
                progressView.progress = 0.0
                self.progressBarTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.updateProgressView), userInfo: nil, repeats: true)
                if(isRed){
                    progressView.progressTintColor = UIColor.blue
                    progressView.progressViewStyle = .default
                }
                else{
                    progressView.progressTintColor = UIColor.red
                    progressView.progressViewStyle = .bar
                    
                }
                isRed = !isRed
                }
                isRunning = !isRunning    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressView.progress = 0.0
        updateProgressView()
        updateProgressView()
    }

    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
    var time: Float = 0.0
    var timer: Timer?
    
    
    @objc func updateProgressView(){
        progressView.progress += 0.1
        progressView.setProgress(progressView.progress, animated: true)
        if(progressView.progress == 1.0)
        {
            progressBarTimer.invalidate()
            isRunning = false
            btn.setTitle("Start", for: .normal)
        }
    }

}

