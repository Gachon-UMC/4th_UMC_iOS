//
//  StoryCollectionViewCell.swift
//  Instagram
//
//  Created by 박민서 on 2023/04/30.
//

import UIKit

//protocol StoryCollectionViewCellDelegate: AnyObject {
//    func didTapImageInCell(_ cell: StoryCollectionViewCell)
//}

class StoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var Color_view: UIView!  //색 테두리를 위한 색 뷰
    @IBOutlet weak var White_View: UIView!  //색 테두리를 위한 흰색 뷰
    @IBOutlet weak var UserImage: UIImageView!  //User의 이미지
    @IBOutlet weak var UserName: UILabel!   //User의 이름
    
    var StoryImage: String = "" //Story의 이미지 소스
    var StoryTime: String = ""  //Story의 업로드된 시간 소스
    var StoryHeart: Bool = false    //Story에 하트를 눌렀는지에 대한 Boolean
    
    var imageViewTappedClosure: (() -> Void)?   //하트를 Tap했을때 본 Cell을 포함하는 CollectionView단에서 호출하는 클로저함수
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Color_view.layer.cornerRadius = 0.5 * Color_view.bounds.size.width
        Color_view.clipsToBounds = true
        White_View.layer.cornerRadius = 0.5 * White_View.bounds.size.width
        White_View.clipsToBounds = true
        UserImage.layer.cornerRadius = 0.5 * UserImage.bounds.size.width
        UserImage.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))   //Image Tap시 처리를 위한 UITapGestureRecognizer 선언
        UserImage.addGestureRecognizer(tapGesture)  //GestureRecognizer에 추가
        UserImage.isUserInteractionEnabled = true   //UserInterAction 활성화
    }
    
    override func prepareForReuse() {   //StoryCollectionViewCell의 dequeue시 ReusableCell의 문제를 막기위한 Cell값 초기화
        super.prepareForReuse()
        Color_view.backgroundColor = UIColor.green
        self.StoryImage = ""
        self.StoryTime = ""
        self.StoryHeart = false
    }
    ///이미지 혹은 셀이 탭되었을 때 호출되는 objc함수
    ///이미지를 tap 시 isImageTap = true, Cell을 tap시 isImageTap = false
    @objc func imageViewTapped( isImageTap : Bool = true) {
        //StoryViewContorller를 선언하여 데이터 저장 후 present
        let StoryViewController = StoryViewController()
        StoryViewController.modalPresentationStyle = .fullScreen
        StoryViewController.userNameText = UserName.text ?? "user_name_err"
        StoryViewController.userImageText = UserImage.image?.accessibilityIdentifier ?? "user_image_err"
        StoryViewController.userTimeText = StoryTime
        StoryViewController.userStoryImageText = StoryImage
        StoryViewController.gotHeart = StoryHeart
        if isImageTap {
            imageViewTappedClosure?()   //CollectionView단에서 구현한 코드로 넘어가서 해당 내용을 CollectionView 단에서 처리
        }
        
        UIApplication.shared.keyWindow?.rootViewController?.present(StoryViewController, animated: true)
        //StoryView present하기
        }

}

