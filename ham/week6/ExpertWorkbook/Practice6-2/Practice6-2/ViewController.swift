//
//  ViewController.swift
//  Practice6-2
//
//  Created by 이재혁 on 2023/05/11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // box 생성
        let box: UIView = {
            let _box = UIView(frame: CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0))
            _box.backgroundColor = UIColor.purple
            return _box
        }()
        view.addSubview(box)
        
        // label 생성
        let label: UILabel = {
            let _label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            _label.center = view.center
            _label.textAlignment = .center
            _label.text = "호호호호호호호호홍"
            return _label
        }()
        view.addSubview(label)
        
        // DispatchGroup 생성
        let animationGroup = DispatchGroup()
        
        // 첫 번째 애니메이션 실행 (내부적으로 비동기) - 박스 크기 키우기
        // 비동기 함수 들어가기 전에 group enter
        animationGroup.enter()
        UIView.animate(withDuration: 5, animations: { [weak self] in
            box.frame = CGRect(x: (self?.view.bounds.midX ?? .zero) - 100,
                               y: (self?.view.bounds.midY ?? .zero) - 100,
                               width: 200, height: 200)},
                       completion: { _ in
            // 비동기 함수 끝나는 시점에 group leave
            animationGroup.leave()
        })
        
        // 두 번째 애니메이션 실행 (내부적으로 비동기) - 백그라운드 색상 변경
        animationGroup.enter()
        UIView.animate(withDuration: 5, animations: { [weak self] in
            self?.view.backgroundColor = UIColor.cyan},
                       completion: { _ in
            animationGroup.leave()
        })
        
        // 애니메이션 모두 종료하는 시점에 notify를 통해 notification block 실행
        animationGroup.notify(queue: DispatchQueue.main) {
            label.text = "애니메이션 종료!"
        }
    }


}

