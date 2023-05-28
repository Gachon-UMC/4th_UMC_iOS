//
//  firstCollectionViewCell.swift
//  Instagram
//
//  Created by YOUJIM on 2023/04/29.
//

import UIKit

// 버튼을 눌렀을 때 데이터 전달을 위한 프로토콜 선언
protocol StoryCellDelegate: AnyObject {
    func didTapButton(at model: Model)
}

class firstCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var tintedButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    
    // 스토리에 데이터 전달하기 위한 변수 선언
    var modelForStory: Model!
    
    // 프로토콜 채택
    weak var delegate: StoryCellDelegate?
    
    override func awakeFromNib() {
        super.prepareForReuse()
        super.awakeFromNib()
        
        profileImage.layer.cornerRadius = 0.5 * profileImage.bounds.size.width
        whiteButton.layer.cornerRadius = 0.5 * whiteButton.bounds.size.width
        whiteButton.clipsToBounds = true
        tintedButton.layer.cornerRadius = 0.5 * tintedButton.bounds.size.width
        tintedButton.clipsToBounds = true
    }
    
    public func configure(with model: Model){
        self.profileImage.setImage(UIImage(named: model.imagename)!.circularImage(), for: .normal)
        self.titleLabel.text = model.id
        self.plusButton.isHidden = model.isNotMine
        
        // 스토리에 전달할 model 데이터 할당
        modelForStory = model
        
        // 본 적 있는 스토리면
        if modelForStory.isWatch == true {
            // 회색 테두리 씌워줌
            tintedButton.backgroundColor = UIColor.lightGray
        }
        else {
            tintedButton.backgroundColor = UIColor(red: 8.0/255.0, green: 225.0/255.0, blue: 114.0/255.0, alpha: 1.0)
        }
        
        // 내 스토리면 테두리 x
        if modelForStory.isNotMine == false {
            tintedButton.backgroundColor = UIColor.clear
        }
        
    }
    
    // 버튼 눌리면 스토리 뜨게 하는 코드
    @IBAction func buttonTapped(_ sender: Any) {
        // 스토리가 있으면
        if modelForStory.hasActiveStory == true {
            // 아직 안 봤으면
            if !modelForStory.isWatch {
                // tableview의 didTapButton을 호출해 순서 바꾸고 배열 데이터를 로컬에 저장
                self.delegate?.didTapButton(at: modelForStory)
                // 여기서(CollectionViewCell) 당장 쓸 modelForStory의 isWatch 변수 값은 수동으로 변경
                modelForStory.isWatch = !modelForStory.isWatch
            }
            // 새로운 화면 present
            let storyVC = StoryViewController()
            storyVC.model = modelForStory
        
            storyVC.modalPresentationStyle = .fullScreen
            UIApplication.shared.windows.first?.rootViewController?.present(storyVC, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                storyVC.dismiss(animated: true, completion: nil)
            }
        }
    }
}

// 버튼 이미지 둥글게
extension UIImage {
    func circularImage() -> UIImage? {
        let shorterSide = min(size.width, size.height)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: shorterSide, height: shorterSide))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = shorterSide / 2.0
        imageView.layer.masksToBounds = true
        imageView.image = self

        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        imageView.layer.render(in: context)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundedImage
    }
}

