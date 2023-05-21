//
//  DelayViewController.swift
//  Instagram
//
//  Created by 이재혁 on 2023/05/19.
//

import UIKit

class DelayViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    var profileInStory: UIImage?
    @IBOutlet weak var userIDLabel: UILabel!
    var userIDInStory: String?
    @IBOutlet weak var dayAgoLabel: UILabel!
    var dayAgoInStory: String?
    @IBOutlet weak var progressBar: UIProgressView!
    var timer: Timer? //타이며 변수
    var elapsedTime: TimeInterval = 0 //경과 시간 저장 변수
    @IBOutlet weak var mainStoryImageView: UIImageView!
    var mainStoryImageInStory: UIImage?
    @IBOutlet weak var DMtextFieldInStory: UITextField!
    
    @IBOutlet weak var storySetButton: UIButton!
    @IBOutlet weak var storyCloseButton: UIButton!
    @IBOutlet weak var storyHeartButton: UIButton!
    var isHeartFilled = false
    @IBOutlet weak var storyDMButton: UIButton!
    
    var modelIdentifier: String?
    @IBAction func storyCloseAction(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
    }
    
    //heart button 누르는 액션
    @IBAction func storyHeartAction(_ sender: Any) {
        isHeartFilled.toggle() //상태 반전
        
        var configuration = UIButton.Configuration.tinted()
        
        if isHeartFilled {
            let filledHeart = UIImage(systemName: "heart.fill")
            // 채워진 하트
            configuration.image = filledHeart
            configuration.baseBackgroundColor = .clear
            storyHeartButton.tintColor = .red
        }
        else {
            let emptyHeart = UIImage(systemName: "heart") // 빈 하트
            configuration.image = emptyHeart
            configuration.baseBackgroundColor = .clear
            storyHeartButton.tintColor = .white
        }
                
        storyHeartButton.configuration = configuration
        
        // UserDefaults로 heart fill 상태 저장
        if let storedData = UserDefaults.standard.data(forKey: "Story_List"), var StoryList = try? JSONDecoder().decode([Model].self, from: storedData) {
            for i in 1..<StoryList.count {
                if StoryList[i].userID == userIDLabel.text {
                    StoryList[i].isHeartFilled = isHeartFilled
                    break
                }
            }
            if let updateStoryList = try? JSONEncoder().encode(StoryList) {
                UserDefaults.standard.set(updateStoryList, forKey: "Story_List")
                UserDefaults.standard.synchronize()
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        var configuration = UIButton.Configuration.tinted()
            
        if isHeartFilled {
            let filledHeart = UIImage(systemName: "heart.fill") // 채워진 하트
            configuration.image = filledHeart
            configuration.baseBackgroundColor = .clear
            storyHeartButton.tintColor = .red
        } else {
            let emptyHeart = UIImage(systemName: "heart") // 빈 하트
            configuration.image = emptyHeart
            configuration.baseBackgroundColor = .clear
        }

        storyHeartButton.configuration = configuration
        
        storySetButton.tintColor = .white
        storyCloseButton.tintColor = .white
        storyHeartButton.tintColor = .white
        storyDMButton.tintColor = .white
        DMtextFieldInStory.layer.cornerRadius = 20
        let placeholderColor = UIColor.white
        
        let placeholderText = "  메시지 보내기"
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor,
            .font: UIFont.systemFont(ofSize: 16) // 원하는 폰트 크기로 조절하실 수 있습니다.
        ];
        DMtextFieldInStory.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: placeholderAttributes)
        
        DMtextFieldInStory.layer.borderColor = UIColor.white.cgColor
        DMtextFieldInStory.layer.borderWidth = 1.0
        containerView.backgroundColor = .black
        
        
        if let mainStoryImageInStory = self.mainStoryImageInStory {
            mainStoryImageView.image = mainStoryImageInStory
        }
        
        if let profileInStory = self.profileInStory {
            profileImageView.image = profileInStory
            profileImageView.layer.cornerRadius = profileImageView.frame.width / 2.0
        }
        
        if let userIDInStory = self.userIDInStory {
            userIDLabel.text = userIDInStory
            userIDLabel.textColor = .white
        }
        
        if let dayAgoInStory = self.dayAgoInStory {
            dayAgoLabel.text = dayAgoInStory
            dayAgoLabel.textColor = .lightGray
        }

        // 초기 progress 0으로 설정
        progressBar.progress = 0
        progressBar.progressTintColor = .white
        
        // 타이머 생성
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in self?.updateProgress()
            
        }
        
        self.view.backgroundColor = .black
        

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    
    func updateProgress() {
        //0.1초마다 elapsedTime 증가
        elapsedTime += 0.01
        
        //5초동안 0에서 1로 증가하는 progress 계산
        let progress = Float(elapsedTime / 5)
        progressBar.setProgress(progress, animated: true)
        
        //5초 지나면 타이머 중지하고 뷰컨 닫음
        if elapsedTime >= 5 {
            timer?.invalidate()
            timer = nil
            dismiss(animated: true, completion: nil)
        }
    }
    
    deinit {
        timer?.invalidate()
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}

