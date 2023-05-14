//
//  LottieViewController.swift
//  ExpertWorkBook
//
//  Created by 박민서 on 2023/05/04.
//

import Foundation
import Lottie
import ParticlesLoadingView

class Lottie_ViewController: UIViewController {
    
    lazy var loadingView: ParticlesLoadingView = {
           let x = UIScreen.main.bounds.size.width / 2 - (75 / 2) // 🙈
           let y = UIScreen.main.bounds.size.height / 2 - (75 / 2) // 🙉
           let view = ParticlesLoadingView(frame: CGRect(x: x, y: y, width: 75, height: 75))
           view.particleEffect = .laser
           view.duration = 1.5
           view.particlesSize = 15.0
           view.clockwiseRotation = true
           view.layer.borderColor = UIColor.lightGray.cgColor
           view.layer.borderWidth = 1.0
           view.layer.cornerRadius = 15.0
           return view
       }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = LottieAnimationView(name:"cycling-in-the-park")
        animationView.frame = CGRect(x:0, y:0, width:300, height: 300)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        //view.addSubview(animationView)
        //animationView.play()
        
        view.addSubview(loadingView)
        loadingView.startAnimating()
        
        /*
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
         */
    }
}
