//
//  ViewController1.swift
//  Instagram
//
//  Created by YOUJIM on 2023/05/18.
//

import UIKit

class ViewController1: UIViewController {

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var storyImage: UIImageView!
    @IBOutlet weak var dmField: UITextField!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var dmButton: UIButton!
    
    // firstCollectionViewCell에서 데이터를 가져오기 위한 변수 선언
    var model: Model!
    
    // 프로그래스 바 구현을 위한 변수 선언
    var timer: Timer?
    var progress: Float = 0.0
    let totalTime: TimeInterval = 5.0
    let timeInterval: TimeInterval = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 하트 버튼 상태 업데이트
        updateHeartButtonImage()
        
        // 버튼 스타일 설정
        profileButton.layer.cornerRadius = 0.5 * profileButton.bounds.size.width
        
        // 텍스트필드의 테두리 스타일 설정
        dmField.layer.borderWidth = 1.0
        dmField.layer.borderColor = UIColor.lightGray.cgColor
        dmField.layer.cornerRadius = 20.0
        
        // 가져온 데이터 할당
        id.text = model?.id
        profileButton.setImage(UIImage(named: model!.imagename)!.circularImage(), for: .normal)
        storyImage.image = UIImage(named: model!.storyName)
        
        // 스토리 이미지 뷰 가득 채우게 설정
        storyImage.layer.cornerRadius = 8.0
        storyImage.contentMode = .scaleToFill
        storyImage.clipsToBounds = true
        
        // 프로그래스 바 초기화하고 타이머 시작
        progressBar.progress = 0.0
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(updateProgressBar), userInfo: nil, repeats: true)
    }
    
    // status bar 글자 색 바꾸기
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent // 어두운 배경에 밝은 글꼴
        }
    
    // 프로그래스 바 업데이트 해주는 함수
    @objc func updateProgressBar() {
            // 프로그래스 바 업데이트
            progress += Float(timeInterval) / Float(totalTime)
            progressBar.progress = progress
            
            // 5초가 지나면 타이머 중지
            if progress >= 1.0 {
                timer?.invalidate()
                timer = nil
        }
    }
    
    // x 버튼 누르면 dismiss
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // 하트 버튼 누르면 바꿔줌
    @IBAction func heartButtonTapped(_ sender: Any) {
        if model.isHeartFilled == true {
            model.isHeartFilled = false
        }
        else {
            model.isHeartFilled = true
        }
        // notification 보내줌
        NotificationCenter.default.post(Notification(name: NSNotification.Name("HeartSend"), object: nil, userInfo: ["heartStatus": model.isHeartFilled]))
        updateHeartButtonImage()
        
    }
    
    // 하트 상태 업데이트 함수
    func updateHeartButtonImage() {
        let heartImage = model.isHeartFilled ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        print(model.isHeartFilled)
        heartButton.setImage(heartImage, for: .normal)
        }
}


