//
//  CustomView.swift
//  MakeCustomButton
//
//  Created by YOUJIM on 2023/04/02.
//

import UIKit

class CustomView: UIView {
    //XIB 이름 미리 선언
    static let identifier = "CustomView"

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    //Storyboard나 다른 XIB가 component를 초기화할 때 실행되는 생성자
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }

    //코드를 통해 component가 초기화될 때 실행되는 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    //initSubViews()는 XIB를 사용하는 custom component를 작동시키는 key
    func initSubviews() {

        let nib = UINib(nibName: CustomView.identifier, bundle: nil)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as?
                            UIView else {fatalError("Unable to convert nib")}

        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(view)

    }
        
    func configureImageAndText(image : UIImage, text : String){
        textLabel.text = text
        imageView.image = image
    }

}
