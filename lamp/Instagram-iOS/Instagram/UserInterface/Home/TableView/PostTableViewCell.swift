//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 박민서 on 2023/05/07.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var UserName: UILabel!   //Post 상단 User 이름
    @IBOutlet weak var UserImage: UIImageView!  //User 프로필 이미지
    @IBOutlet weak var PostImage: UIImageView!  //Post 메인 이미지
    @IBOutlet weak var PostLike: UILabel!   //Post의 좋아요 개수 라벨
    @IBOutlet weak var UserID: UILabel!     //PostImage아래 User 이름, ID.
    @IBOutlet weak var User_Text: UILabel!  //UserID 옆 Post의 본문
    @IBOutlet weak var CommentCount: UILabel!   //Post의 댓글 개수
    @IBOutlet weak var PostDate: UILabel!       //Post가 업로드된 날짜
    @IBOutlet weak var Like_Button: UIButton!   //PostImage 아래 좋아요 하트 버튼
    
    var postGotHeart: Bool = false  //Post에 하트를 눌렀는지에 대한 Bool값
    var postLikeNum: Int = 0        //Post의 좋아요 갯수

    override func awakeFromNib() {
        super.awakeFromNib()
        UserImage.layer.cornerRadius = 0.5 * UserImage.bounds.size.width    //UserImage 레이어 동그라미로 만들기
        UserImage.clipsToBounds = true  //UserImage에서 layer 밖으로 나온 이미지 clipping하기
        PostImage.isUserInteractionEnabled = true   //PostImage: UIImageView를 User가 상호작용이 가능하게 만들기
        PostLike.isUserInteractionEnabled = true    //PostLike: UILabel를 User가 상호작용이 가능하게 만들기
        
        //TapGetureRecognizer를 설정에 맞추어 각 View들에 추가하는 과정
        TapFuncRegister(selector: #selector(doubleTap), numberOfTapsRequired: 2, targetView: self.PostImage)
        TapFuncRegister(selector: #selector(heartTap), numberOfTapsRequired: 1, targetView: self.Like_Button)
        TapFuncRegister(selector: #selector(likelabelTap), numberOfTapsRequired: 1, targetView: self.PostLike)
    }
    
    func TapFuncRegister(selector: Selector, numberOfTapsRequired: Int, targetView: UIView){
        let TapGesture = UITapGestureRecognizer(target: self, action: selector) //select 함수를 action으로 갖는 TapGestureRecognizer 객체 선언
        TapGesture.numberOfTapsRequired = numberOfTapsRequired  //필요한 탭 수 설정
        targetView.addGestureRecognizer(TapGesture) //해당 Gesture인식기를 targetView에 추가하기
    }
    
    /// 이미지를 두번 탭하는 제스처를 했을 때 호출되는 함수
    @objc func doubleTap (_ sender: UITapGestureRecognizer) {
        let WhiteHeartImageView = UIImageView(image: UIImage(named: "WhiteHeart"))  //하얀색 하트를 이미지로 갖는 하트이미지뷰 생성
        WhiteHeartImageView.bounds.size = CGSize(width: 0, height: 0)   //초기 사이즈는 높이,너비 0로 설정
        WhiteHeartImageView.center.x = self.PostImage.frame.width/2  //하트이미지뷰의 midX는 PostImage뷰의 너비값 절반과 똑같게 설정
        WhiteHeartImageView.center.y = self.PostImage.frame.height/2    //하트이미지뷰의 midY는 PostImage뷰의 높이값 절반과 똑같게 설정
        
        PostImage.addSubview(WhiteHeartImageView)   //PostImage이미지뷰에 SubView로 하트이미지뷰를 추가
        
        // 하트가 눌려있지 않다면 heartTap objc함수를 호출 -> PostLike 수정 + 빨간 하트 애니메이트 수행
        if postGotHeart == false { heartTap(sender) }
        
        //Spring처럼 튀어오르는 애니메이션 실행
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.4, animations: {
            WhiteHeartImageView.bounds.size = CGSize(width: 100, height: 100)
            //0,0에서 100,100까지 커지는 애니메이션
        }, completion: { (_) in //첫번째 애니메이션이 완료되었을 때 실행
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [], animations:{
                WhiteHeartImageView.bounds.size = CGSize(width: 5, height: 5)
                WhiteHeartImageView.alpha = 0.7
                //100,100에서 5,5로 작아지는 애니메이션
            }, completion: { (_) in //두번째 애니메이션이 완료되었을 때 실행
                WhiteHeartImageView.removeFromSuperview()
                //하트이미지뷰를 PostImage뷰에서 제거
            })
        })
    }
    
    ///하트 버튼을 탭하는 제스처를 했을때 호출되거나, doubleTap에서 호출되었을때 작동하는 함수
    @objc func heartTap (_ sender: UITapGestureRecognizer) {
        if postGotHeart == true {   //하트가 이미 눌려있을때
            Like_Button.setImage(UIImage(named: "Heart"), for: .normal) //하트 버튼의 이미지소스 빈 하트로 설정
            postLikeNum -= 1    // 해당 post의 좋아요 개수 차감
            PostLike.text = "좋아요 \(postLikeNum)개"   // UI요소에 좋아요 개수 반영
            postGotHeart = false    //해당 post는 하트 받지 않은걸로 변경
        }else if postGotHeart == false {    //하트가 눌려있지 않을 때
            
            if let Heartimage = UIImage(named: "RedHeart") {    //빨간 하트 이미지 소스를 UIImage로 불러옴
                let resizedImage = resizeImage(image: Heartimage, targetSize: CGSize(width: 25, height: 25))    //25,25로 리사이즈하는 함수 호출 -> 해당 사이즈로 리사이즈한 이미지 저장
                Like_Button.setImage(resizedImage, for: .normal)    //리사이즈된 이미지로 좋아요버튼의 이미지소스 설정
            }
            
            ///스프링댐핑 애니메이션
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, animations: {
                self.Like_Button.imageView?.bounds.size = CGSize(width: 45, height: 45) //좋아요 버튼의 이미지 사이즈가 45,45로 커지며 애니메이트
            }, completion: {finished in //커지는 애니메이션이 끝나면
                self.Like_Button.imageView?.bounds.size = CGSize(width: 40, height: 40) // 좋아요 버튼의 이미지 사이즈를 40,40으로 재설정
            })
            
            postLikeNum += 1    //해당 post의 좋아요 개수 추가
            PostLike.text = "좋아요 \(postLikeNum)개"   // UI요소에 좋아요 개수 반영
            postGotHeart = true  //해당 post는 하트 받은걸로 변경
        }
        regist_Heart()   //post_list에 변경사항을 반영하는 함수 호출
    }
    
    /// 좋아요 개수 label을 탭하는 제스처를 했을때 호출되는 함수
    @objc func likelabelTap (_ sender: UITapGestureRecognizer) {
        print(self.PostLike.text!)  //좋아요 개수 출력
    }
    
    //입력받은 image를 targetSize에 맞추어 resizing 해주는 함수
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: targetSize)    // targetSize에 맞춘 imageRenderer 선언
        let resizedImage = renderer.image { _ in        //renderer.image에 클로저 추가
            image.draw(in: CGRect(origin: .zero, size: targetSize)) // image를 0,0을 시점으로 targetSize만큼의 사이즈로 그려낸다.
        }
        return resizedImage // targetSize로 재생성된 이미지 반환
    }
    
    ///post_list에 변경사항을 반영하는 함수
    func regist_Heart() {
        for i in 0..<post_list.count {
            if post_list[i].UserID == self.UserID.text {    //해당 post_list에서 post와 일치하는 post객체 찾기
                post_list[i].GotHeart = self.postGotHeart   // 변경내용 반영
                post_list[i].PostLike = self.postLikeNum
            }
        }
    }
    
    ///상위 TableView에서 해당 Cell에 데이터를 넘겨줄 때 호출하는 함수.
    func setData(_ post: post) {
        self.UserID.text = post.UserID
        self.UserName.text = post.UserID
        self.UserImage.image = UIImage(named: post.UserImage) ?? UIImage()
        self.PostImage.image = UIImage(named: post.PostImage) ?? UIImage()
        self.PostLike.text = "좋아요 \(post.PostLike)개"
        self.User_Text.text = post.UserText
        self.CommentCount.text = "댓글 \(post.CommentCount)개 모두 보기"
        self.PostDate.text = post.PostDate
        self.postGotHeart = post.GotHeart
        self.postLikeNum = post.PostLike
               
        if postGotHeart == true {
            if let Heartimage = UIImage(named: "RedHeart") {
                let resizedImage = resizeImage(image: Heartimage, targetSize: CGSize(width: 25, height: 25))
                Like_Button.setImage(resizedImage, for: .normal)
            }
        }else if postGotHeart == false {
            Like_Button.setImage(UIImage(named: "Heart"), for: .normal)
        }
    }
    
}
