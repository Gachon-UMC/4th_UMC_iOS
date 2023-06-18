//
//  TableViewCell.swift
//  Instagram
//
//  Created by 이재혁 on 2023/05/04.
//

import UIKit
import AlamofireImage

var profileIdForClass : UILabel!

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var Nakami: UILabel!
    @IBOutlet weak var feedUserID: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileID: UILabel!
    @IBOutlet weak var feedImg: UIImageView!
    @IBOutlet weak var heartButton: HeartButton!
    
    var numOfLike : Int!
    
    var profileUrl: String!
    var feedUrl: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // AlamofireImage로 HomeVC에서 할당받은 url string 통해서 이미지 데이터 다운로드,세팅
        DispatchQueue.main.async {
            if let url = URL(string: self.profileUrl) {
                self.profileImg.af.setImage(withURL: url)
            }
            if let url = URL(string: self.feedUrl) {
                self.feedImg.af.setImage(withURL: url)
            }
        }
        
        
        //피드 이미지 더블탭 이벤트
        feedImg.isUserInteractionEnabled = true
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        feedImg.addGestureRecognizer(doubleTapGesture)
        
        heartButton.setLabelToAddClosure = {
            // 좋아요 수 증가
            self.numOfLike += 1
            self.saveToLocal()
        }
        
        heartButton.setLabelToMinusClosure = {
            // 좋아요 수 감소
            self.numOfLike -= 1
            self.saveToLocal()
        }
        
        //좋아요 개수 출력 이벤트
        likeCount.isUserInteractionEnabled = true
        let clickLikeLabel = UITapGestureRecognizer(target: self, action: #selector(clickLabel))
        likeCount.addGestureRecognizer(clickLikeLabel)
        
        
    }
    @objc func clickLabel(sender: UITapGestureRecognizer) {
        print(likeCount.text ?? "No text")
    }
    
    // configure: 셀 각 UI 정보
    func configure(feedmodel: FeedModel) {
        profileID.text = feedmodel.profileID
        feedUserID.text = feedmodel.profileID
        likeCount.text = "좋아요 \(feedmodel.like)개"
        commentCount.text = "댓글 \(feedmodel.comment)개 모두 보기"
        commentCount.textColor = UIColor.lightGray
        Nakami.text = "\(feedmodel.feedText)"
        dateLabel.text = "\(feedmodel.date)"
        dateLabel.textColor = UIColor.lightGray
        heartButton.isLiked = feedmodel.isHeartFilled
        numOfLike = feedmodel.like
        
        let image = heartButton.isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        self.heartButton.setImage(image, for: .normal)
        self.heartButton.tintColor = heartButton.isLiked ? .red : .black

    }
    
    // saveToLocal: UserDefaults 불러와서 저장
    func saveToLocal() {
        //23.5.25 FeedData q불러오기
        if let storedFeedData = UserDefaults.standard.data(forKey: "Feed_List"),
           // MARK: 유저디폴트 데이터를 불러와서
           var feedList = try? JSONDecoder().decode([FeedModel].self, from: storedFeedData){
            // MARK: id가 같으면 feedList(decode한 배열)의 isHeartFilled 값을 바꿔줌
            for i in 0..<feedList.count {
                if feedList[i].profileID == self.profileID.text {
                    feedList[i].isHeartFilled = self.heartButton.isLiked ?? false
                    if feedList[i].isHeartFilled {feedList[i].like += 1}
                    else {feedList[i].like -= 1}
                    self.likeCount.text = "좋아요 \(feedList[i].like)개"
                    
                    break
                }
            }
            
            if let updatedFeedList = try? JSONEncoder().encode(feedList) {
                UserDefaults.standard.set(updatedFeedList, forKey: "Feed_List")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    @objc func didDoubleTap(_ gesture: UITapGestureRecognizer) {
        let imageViewCenter = feedImg.center
        
        let heartImageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        heartImageView.center = imageViewCenter
        heartImageView.tintColor = .white
        
        self.addSubview(heartImageView)
        
        // 첫 번째 애니메이션: 이미지 뷰 확대
        UIView.animate(withDuration: 0.25, animations: {
            heartImageView.tintColor = .white
            heartImageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }, completion: { _ in
            // 두 번째 애니메이션: 이미지 뷰 축소
            UIView.animate(withDuration: 0.125, animations: {
                heartImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { _ in
                // 세 번째 애니메이션: 이미지 뷰 투명하게 만들고 제거
                UIView.animate(withDuration: 0.1, animations: {
                    heartImageView.alpha = 0.0
                    heartImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                }, completion: { _ in
                    heartImageView.removeFromSuperview()
                })
            })
        })
        // heartbutton이 채워져있지 않을 때만 좋아요 수 UP
        if heartButton.isLiked == false {heartButton.buttonTapped()}
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}

// 하트 버튼 커스텀 클래스
class HeartButton: UIButton {
    
    var setLabelToAddClosure: (() -> Void)?
    var setLabelToMinusClosure: (() -> Void)?
    // 버튼의 초기 상태를 설정
    var isLiked = false

    // 초기 설정
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.updateButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.updateButton()
    }
    
    // 버튼 클릭시
    @objc func buttonTapped() {
        self.isLiked.toggle()
        updateButton()
    }
    
    // 버튼 상태 업데이트
    func updateButton() {
        let image = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        self.setImage(image, for: .normal)
        self.tintColor = isLiked ? .red : .black
        if isLiked == true {
            setLabelToAddClosure?()
        }
        else {
            setLabelToMinusClosure?()
        }
        animate()
    }
    
    // 애니메이션
    func animate() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { finish in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
    }
}
