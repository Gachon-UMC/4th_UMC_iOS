//
//  StoryViewController.swift
//  Instagram
//
//  Created by 박민서 on 2023/05/18.
//

import UIKit

class StoryViewController: UIViewController {

    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var StoryTime: UILabel!
    @IBOutlet weak var ProgressView: UIProgressView!
    @IBOutlet weak var UserImage: UIButton!
    @IBOutlet weak var DotButton: UIButton!
    @IBOutlet weak var XButton: UIButton!
    @IBOutlet weak var HeartButton: UIButton!
    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var MessageText: UITextField!
    @IBOutlet weak var StoryImage: UIImageView!
    
    /// X마크 누르면 dismiss
    @IBAction func didTapXmark(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /// 하트를 누르면 기존의 하트가 눌렸었는지에 따라 분기 작업 수행
    @IBAction func didTapHeart(_ sender: Any) {
            if HeartButton.currentImage?.accessibilityIdentifier! == "Heart" {
                HeartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                gotHeart = true

            } else if HeartButton.currentImage?.accessibilityIdentifier! == "heart.fill" {
                HeartButton.setImage(UIImage(named:"Heart")?.withRenderingMode(.alwaysTemplate), for: .normal)
                HeartButton.tintColor = UIColor.white
                gotHeart = false
            }
    }

    
    var userNameText: String = ""   //user의 이름
    var userImageText: String = ""  //user의 프로필 이미지 소스
    var userTimeText: String = ""   //user의 업로드된 시간
    var userStoryImageText: String = "" //user의 Story이미지 소스
    var gotHeart: Bool = false  //user의 Story가 하트를 받았는지
    
    var timer: Timer?   // progressView를 위한 타이머
    var progress: Float = 0.0   //progress된 값
    let totalTime: Float = 5.0  //타이머 맥스값
    let interval: TimeInterval = 0.01   //타이머 addingInterveal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSource() //불러온 값 UI소스에 dispatch
        //ProgressView UI변경
        ProgressView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0 / ProgressView.frame.size.height)
        ProgressView.progressTintColor = UIColor.white.withAlphaComponent(0.7)
        ProgressView.trackTintColor = UIColor.white.withAlphaComponent(0.4)
        
        //버튼들 UI변경
        DotButton.setWhite(ImageName: "Ellipsis")
        XButton.setWhite(ImageName: "xmark")
        ShareButton.setWhite(ImageName: "Share")
        
        //하트 눌렸었는지에 따라 하트 버튼 UI 변경
        if gotHeart {
            HeartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            HeartButton.setImage(UIImage(named:"Heart")?.withRenderingMode(.alwaysTemplate), for: .normal)
            HeartButton.tintColor = UIColor.white

        }
        
        //유저, 스토리 이미지, 텍스트필드 UI 변경
        UserImage.layer.cornerRadius = 0.5 * UserImage.bounds.size.width
        UserImage.clipsToBounds = true
        
        StoryImage.layer.cornerRadius = 0.02 * StoryImage.bounds.size.width
        StoryImage.clipsToBounds = true
        
        MessageText.textColor = UIColor.white
        MessageText.borderStyle = .roundedRect
        MessageText.layer.borderColor = UIColor.white.withAlphaComponent(0.7).cgColor
        MessageText.layer.borderWidth = 1.0
        MessageText.layer.cornerRadius = 22.0
        MessageText.backgroundColor = UIColor.clear
        MessageText.attributedPlaceholder = NSAttributedString(string: "   메시지 보내기", attributes: [.foregroundColor: UIColor.white])
        
        //progressView 타이머 생성
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        
        //5초후 dismiss를 위한 비동기 처리
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    ///progressView 실시간 업데이팅을 위한 objc 함수
    @objc func updateProgress() {
        progress += Float(interval) / totalTime
                ProgressView.progress = progress
                
                if progress >= 1.0 {
                    timer?.invalidate()
                    timer = nil
                }
    }
    
    ///불러온 값 UI소스에 dispatch하는 함수
    func setSource(){
        UserName.text = userNameText
        UserImage.setImage(UIImage(named: userImageText) ?? UIImage(), for: .normal)
        StoryTime.text = userTimeText
        StoryImage.image = UIImage(named: userStoryImageText) ?? UIImage()
    }
    
    ///View가 사라질때 (명확히는 사라지기 바로전) 호출
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 하트에 관련된 알림 게시
        let notification = Notification(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: ["gotHeart": gotHeart, "storyname": userStoryImageText])
        NotificationCenter.default.post(notification)
        
    }
    
    ///검은 화면의 status bar 글씨 색을 위한 UI 변경
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // 밝은 배경에 어두운 글꼴
    }

}

/// Button UI를 변경하는 함수 선언
extension UIButton {
    func setWhite(ImageName: String){
        self.setImage(UIImage(named: ImageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.tintColor = UIColor.white
        self.backgroundColor = UIColor.clear
    }
}


