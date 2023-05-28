//
//  ViewController.swift
//  Practice8-3
//
//  Created by 이재혁 on 2023/05/24.
//

import UIKit

class ViewController: UIViewController {
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "testImage"))
        imageView.isUserInteractionEnabled = true
        //이를 설정해야 imageView가 제스처를 인식할 수 있음
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.frame = view.bounds
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTapGesture)
    }

    @objc func didDoubleTap(_ gesture: UITapGestureRecognizer) {
        // UIView.animate 메서드를 사용해 회전 애니메이션 적용
        UIView.animate(withDuration: 0.2) {
            // 이미지 뷰 180도 회전
            self.imageView.transform = self.imageView.transform.rotated(by: .pi)
        }
    }

}

