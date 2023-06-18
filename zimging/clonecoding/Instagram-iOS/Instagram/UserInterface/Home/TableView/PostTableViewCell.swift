//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by YOUJIM on 2023/05/04.
//

import UIKit
import Alamofire
import AlamofireImage

class PostTableViewCell: UITableViewCell {
    
    // userDefault 저장을 위해 post 데이터를 configure()에서 받아와야 함
    // 받아올 변수 선언
    var postDataInCell : Post!
    
    // 데이터 영구 저장을 위해 posts 배열과 현재 인덱스(몇번째 게시물인지)를 저장할 새로운 변수들이 필요함
    var postsToSave = [Post]()
    var postIndex : Int!
    
    // UserDefault를 위한 encoder 변수 선언
    let encoder = JSONEncoder()
    
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var profileId: UILabel!
    @IBOutlet weak var ellipsis: UIButton!
    @IBOutlet weak var postImage: UIButton!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var dmBtn: UIButton!
    @IBOutlet weak var markBtn: UIButton!
    
    @IBOutlet weak var numOfLikeLabel: UILabel!
    @IBOutlet weak var postIdBtn: UIButton!
    @IBOutlet weak var postContent: UILabel!
    
    @IBOutlet weak var numOfComment: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileBtn.layer.cornerRadius = 0.5 * profileBtn.bounds.size.width
        profileBtn.clipsToBounds = true
        postIdBtn.invalidateIntrinsicContentSize()
        
        // postImage 더블클릭했을 때 제스처 추가
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapPostImage(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        postImage.addGestureRecognizer(doubleTapGesture)
        
        //라벨에 탭 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap(_:)))
        numOfLikeLabel.isUserInteractionEnabled = true
        numOfLikeLabel.addGestureRecognizer(tapGesture)
    }
    
    public func configure(with postInfo: forPostConfigure){
        
        // HomeViewController에서 불러온 posts 배열 중 해당 인덱스 데이터를 postDataInCell에 저장함
        postDataInCell = postInfo.posts[postInfo.index]
        
        // 업데이트 된 좋아요 개수 영구저장을 위한 posts 배열과 인덱스 저장
        postsToSave = postInfo.posts
        postIndex = postInfo.index
        
        // 하트 크기 맞춰주기 위한 padding 변수 선언
        let padding = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
        
        // 프로필 사진 불러오기
        AF.request(postDataInCell.info.imagename).responseImage { response in
            switch response.result {
            case .success(let image):
                // 이미지 다운로드 성공 시 profileBtn으로 설정
                self.profileBtn.setImage(image, for: .normal)
            case .failure(let error):
                // 이미지 다운로드 실패 시 에러 처리
                print("이미지 다운로드 실패: \(error)")
            }
        }
        
        // 게시물 사진 불러오기
        AF.request(postDataInCell.imageName).responseImage { response in
            switch response.result {
            case .success(let image):
                // 이미지 다운로드 성공 시 postImage로 설정
                print("----게시물: \(image)-----")
                self.postImage.setImage(image, for: .normal)
            case .failure(let error):
                // 이미지 다운로드 실패 시 에러 처리
                print("이미지 다운로드 실패: \(error)")
            }
        }
        
        
        
        self.profileId.text = postDataInCell.info.id
        
        self.postContent.text = postDataInCell.imageComment
        self.postIdBtn.titleLabel?.text = postDataInCell.info.id
        
        self.numOfLikeLabel.text = "좋아요 \(postDataInCell.numOfLike)개"
        self.numOfComment.titleLabel?.text = "댓글 \(postDataInCell.numOfComment)개 보기"
        self.dateLabel.text = "    \(postDataInCell.month)월 \(postDataInCell.day)일"
        
        // isHeartFilled 변수가 true면 빨간 하트 표시
        if postDataInCell.isHeartFilled == true {
            self.likeBtn.setImage(UIImage(named: "RedHeart")?.scaledToFitWithPadding(buttonSize: self.likeBtn.bounds.size, padding: padding), for: .normal)
        }
    }
    
    // numOfLikeLabel에서 탭 이벤트가 발생했을 때 프린트하는 함수
    @objc func handleLabelTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            print("\(postDataInCell.numOfLike)")
        }
    }
    
    
    // postImage에서 더블클릭 이벤트가 발생했을 때 수행될 함수
    @objc func handleDoubleTapPostImage(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .recognized {
            // 좋아요가 눌린 상태면
            if postDataInCell.isHeartFilled == true {
                // 하얀 하트 이미지를 생성하고 위치를 버튼의 가운데로 설정
                let heartImageView = UIImageView(image: UIImage(named: "WhiteHeart"))
                heartImageView.center = postImage.center
                
                // 애니메이션을 적용하여 하얀 하트 이미지를 확대하고 축소시킨 후 제거
                UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseOut], animations: {
                    heartImageView.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
                }, completion: { _ in
                    UIView.animate(withDuration: 0.5, animations: {
                        heartImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                        heartImageView.alpha = 0.0
                    }, completion: { _ in
                        heartImageView.removeFromSuperview()
                    })
                })
                
                // 화면에 하얀 하트 이미지를 추가
                self.addSubview(heartImageView)
                
                // likeBtn에서 좋아요 누르는 애니메이션 실행
                UIView.animate(withDuration: 0.2, animations: {
                    let padding = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
                    
                    // 이미지 변경 애니메이션 (빨갛게)
                    let imageName = self.postDataInCell.isHeartFilled ? "likeButtonSelected" : "likeButtonNormal"
                    self.likeBtn.setImage(UIImage(named: "RedHeart")?.scaledToFitWithPadding(buttonSize: self.likeBtn.bounds.size, padding: padding), for: .normal)
                    
                    // 크기 변화 애니메이션 (작아졌다 커지게)
                    let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
                    scaleAnimation.duration = 0.2
                    scaleAnimation.fromValue = 1.0
                    scaleAnimation.toValue = 0.8
                    scaleAnimation.autoreverses = true
                    self.likeBtn.layer.add(scaleAnimation, forKey: "scale")
                })
            }
            // 좋아요가 눌린 상태가 아니면
            else {
                // isHeartFilled 상태를 true로 바꿔줌
                postDataInCell.isHeartFilled = true
                
                // 하얀 하트 이미지를 생성하고 위치를 버튼의 가운데로 설정
                let heartImageView = UIImageView(image: UIImage(named: "WhiteHeart"))
                heartImageView.center = postImage.center
                
                // 애니메이션을 적용하여 하얀 하트 이미지를 확대하고 축소시킨 후 제거
                UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseOut], animations: {
                    heartImageView.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
                }, completion: { _ in
                    UIView.animate(withDuration: 0.5, animations: {
                        heartImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                        heartImageView.alpha = 0.0
                    }, completion: { _ in
                        heartImageView.removeFromSuperview()
                    })
                })
                
                // 화면에 하얀 하트 이미지를 추가
                self.addSubview(heartImageView)
                
                // likeBtn에서 좋아요 누르는 애니메이션 실행
                UIView.animate(withDuration: 0.2, animations: {
                    let padding = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
                    
                    // 이미지 변경 애니메이션 (빨갛게)
                    let imageName = self.postDataInCell.isHeartFilled ? "likeButtonSelected" : "likeButtonNormal"
                    self.likeBtn.setImage(UIImage(named: "RedHeart")?.scaledToFitWithPadding(buttonSize: self.likeBtn.bounds.size, padding: padding), for: .normal)
                    
                    // 크기 변화 애니메이션 (작아졌다 커지게)
                    let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
                    scaleAnimation.duration = 0.2
                    scaleAnimation.fromValue = 1.0
                    scaleAnimation.toValue = 0.8
                    scaleAnimation.autoreverses = true
                    self.likeBtn.layer.add(scaleAnimation, forKey: "scale")
                })
                
                
                // MARK: 좋아요 개수 하나 증가시키고 '좋아요 n개' 텍스트 업데이트
                postDataInCell.numOfLike += 1
                self.numOfLikeLabel.text = "좋아요 \(postDataInCell.numOfLike)개"
                
                // 좋아요 개수 업데이트 된 건 postsToSave 배열에 저장하고 encode
                postsToSave[postIndex] = postDataInCell
                if let encoded = try? encoder.encode(postsToSave) {
                    UserDefaults.standard.set(encoded, forKey: "postLists")
                }
            }
        }
    }
    
    // 좋아요 버튼 이벤트
    @IBAction func pressedLikeButton(_ sender: UIButton) {
        // 이미 선택되어 있으면
        if postDataInCell.isHeartFilled == true {
            
            // 선택 풀어주고 (좋아요 누르기 취소)
            postDataInCell.isHeartFilled = false
            
            // 이미지 예전 상태로 돌림
            sender.setImage(UIImage(named: "Heart"), for: .normal)
            
            // MARK: 좋아요 개수 하나 감소
            postDataInCell.numOfLike -= 1
            self.numOfLikeLabel.text = "좋아요 \(postDataInCell.numOfLike)개"
            
            // 좋아요 개수 업데이트 된 건 postsToSave 배열에 저장하고 encode
            postsToSave[postIndex] = postDataInCell
            if let encoded = try? encoder.encode(postsToSave) {
                UserDefaults.standard.set(encoded, forKey: "postLists")
            }
            
        }
        // 선택이 되어있지 있으면
        else {
            
            // 선택해주고 (좋아요 누름)
            postDataInCell.isHeartFilled = true
            
            // MARK: 좋아요 개수 하나 증가
            postDataInCell.numOfLike += 1
            self.numOfLikeLabel.text = "좋아요 \(postDataInCell.numOfLike)개"
            
            // 좋아요 개수 업데이트 된 건 postsToSave 배열에 저장하고 encode
            postsToSave[postIndex] = postDataInCell
            if let encoded = try? encoder.encode(postsToSave) {
                UserDefaults.standard.set(encoded, forKey: "postLists")
            }
            
            // 좋아요 누르는 애니메이션 실행
            UIView.animate(withDuration: 0.2, animations: {
                let padding = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
                
                // 이미지 변경 애니메이션 (빨갛게)
                let imageName = self.postDataInCell.isHeartFilled ? "likeButtonSelected" : "likeButtonNormal"
                sender.setImage(UIImage(named: "RedHeart")?.scaledToFitWithPadding(buttonSize: self.likeBtn.bounds.size, padding: padding), for: .normal)
                
                // 크기 변화 애니메이션 (작아졌다 커지게)
                let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
                scaleAnimation.duration = 0.2
                scaleAnimation.fromValue = 1.0
                scaleAnimation.toValue = 0.8
                scaleAnimation.autoreverses = true
                sender.layer.add(scaleAnimation, forKey: "scale")
            })
        }
    }
}

extension UIImage {
    // 좋아요 버튼 눌렀을 때 바뀌는 이미지 크기를 버튼에 맞추기 위해 scaledToFitWithPadding 함수 선언
    func scaledToFitWithPadding(buttonSize: CGSize, padding: UIEdgeInsets) -> UIImage? {
        let paddedSize = CGSize(width: buttonSize.width - padding.left - padding.right,
                                height: buttonSize.height - padding.top - padding.bottom)
        UIGraphicsBeginImageContextWithOptions(buttonSize, false, 0.0)
        
        let drawRect = CGRect(x: padding.left, y: padding.top, width: paddedSize.width, height: paddedSize.height)
        draw(in: drawRect)
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
}
