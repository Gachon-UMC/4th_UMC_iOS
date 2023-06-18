//
//  SignInViewController.swift
//  Instagram
//
//  Created by 박민서 on 2023/05/27.
//

import UIKit

///Sign-In 메인 첫번째 로그인화면 뷰컨트롤러 입니다
class SignInViewController: UIViewController {
    

    @IBOutlet weak var EmailTextField: defaultTextField!    //이메일 주소 -> defaultTextField클래스 본 파일에 후술되니 참조
    @IBOutlet weak var PasswordTextField: PassWordTextField!    //비밀번호 -> PassWordTextField클래스 본 파일에 후술되니 참조
    @IBOutlet weak var lostPassword: UIButton!
    @IBOutlet weak var FailureLabel: UILabel!
    
    @IBOutlet weak var LogInButton: UIButton!
    @IBOutlet weak var LogInFaceBookButton: UIButton!
    
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var BottomBorderView: UIView!    //테두리 표시를 위한 뷰
    
    ///가입하기 버튼 tapAction
    @IBAction func SignInTap(_ sender: Any) {
        //gurad로 이메일 주소 작성 화면 받아옵니다. 현재 storyboard의 identifier가 "AddEmailVC"인 뷰컨트롤러를 가지고 옵니다.
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "AddEmailVC") else {return}
        nextVC.modalPresentationStyle = .fullScreen //default값에서 fullscreen으로 변경
        present(nextVC, animated: true)
    }
    
    ///로그인 버튼 tapAction
    @IBAction func tap_LogInButton(_ sender: Any) {
        
        //server 연결 전 자체적으로 EmailTextField를 검수
        guard let InputID = EmailTextField.text else {
            self.EmailTextField.layer.borderColor = UIColor.red.cgColor // EmailTextField 테두리 빨간색으로 변경
            self.FailureLabel.text = "사용자 이름 오류" // PasswordTextField 아래의 오류 표시 Label의 텍스트를 변경
            self.FailureLabel.isHidden = false // FailureLabel 보이게
            return
        }
        
        //EmailTextField == ID의 결과가 true일 때, 원래 테두리 색으로 돌아옵니다.
        self.EmailTextField.layer.borderColor = UIColor.systemGray5.cgColor
        
        //server 연결 전 자체적으로 PasswordTextField를 검수
        guard let InputPW = PasswordTextField.text else {
            self.PasswordTextField.layer.borderColor = UIColor.red.cgColor // EmailTextField 테두리 빨간색으로 변경
            self.FailureLabel.text = "비밀번호 오류" // PasswordTextField 아래의 오류 표시 Label의 텍스트를 변경
            self.FailureLabel.isHidden = false // FailureLabel 보이게
            return
        }
        
        //PasswordTextField == PW의 결과가 true일 때, 원래 테두리 색으로 돌아옵니다.
        self.PasswordTextField.layer.borderColor = UIColor.systemGray5.cgColor
        
        /// 로그인 시도 정보를 POST하는 함수를 호출합니다.
        ///  문제가 없을 시 유저 프로필화면으로 이동합니다.
        ///  문제가 있는 경우는 default case로, PasswordTextField 아래에 오류 메시지를 출력합니다.
        APIManger.shared.POST_LogIn(userInfo: InputID, userPwd: InputPW) { result in
            switch result?.returnCode {
            case 1000 :
                //EmailTextField == ID, PasswordTextField == PW의 결과가 모두 true입니다. 오류 메시지를 감춥니다.
                self.FailureLabel.isHidden = true
                
                //"main"스토리보드에 있는 TabBarController를 가져옵니다. 이때 identifier를 명시하고, TabBarController로 타입캐스팅 해줍니다.
                let myTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: TabBarController.identifier) as? TabBarController
                myTabBarController!.modalPresentationStyle = .fullScreen //출력형태는 .fullscreen으로 바꿔줍니다.
                
                self.present(myTabBarController!, animated: true)
                myTabBarController!.selectedIndex = 4   //기존의 myTabBarController의 Index = 4 는 마이 프로필 탭입니다.
                
            default :
                self.FailureLabel.text = result?.returnMsg // PasswordTextField 아래의 오류 표시 Label의 텍스트를 변경
                self.FailureLabel.isHidden = false // FailureLabel 보이게
            }
        }
    }
    
    ///로그인 본 화면 viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BottomBorderView.layer.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0) // 화면의 "또는" 라벨에 위치한 테두리 추가 (.addBorder는 CALayer 내장함수가 아닌 추가작성 함수임. definition 참조)
        
        ///화면 상의 각 TextField들의 작성 여부를 확인하는 NotificationObserver 생성
        ///해당 Notification들은 defaultTexrField Class의  .addTarget selector -> @objc func textFieldDidChange 에서 호출함.
        NotificationCenter.default.addObserver(forName: Notification.Name("CheckFields"), object: nil, queue: .main, using: {notification in
            self.CheckFieldsToEnable() //CheckFieldsToEnable() 참고
        })
        NotificationCenter.default.addObserver(forName: Notification.Name("Disable"), object: nil, queue: .main, using: {notification in
            self.LogInButton.isEnabled = false // 로그인 버튼 비활성화
        })
        
    }
    
    ///// ID,PW 모두 작성되었는지 확인하는 함수
    func CheckFieldsToEnable() {
        if let textID = EmailTextField.text, !textID.isEmpty, let textPW = PasswordTextField.text, !textPW.isEmpty{
            LogInButton.isEnabled = true // 로그인 버튼 비활성화
        }
    }
    
}

///화면 최하단의 가입하기, 로그인 버튼이 포함된 StackView를 포함한 View입니다. 테두리와 색적용만 포함되어있습니다. storyboard에서 class 지정해주었으니 참고
class BottomViewWithBorder : UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.layer.addBorder([.top], color: UIColor.systemGray5, width: 1.0) //StoryTableViewCell에 하단 테두리 추가 -> StoryCell이 포함된 container에 테두리 효과
    }
    
}

///로그인, 가입 하는 SignIN_storyboard의 모든 VC에서 쓰이는 TextField 상속 클래스입니다.
///UI 디테일과 내부 Padding, @objc func textFieldDidChange를 다룹니다.
class defaultTextField : UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //둥근 테두리 설정
        self.borderStyle = .roundedRect
        self.layer.borderColor = UIColor.systemGray5.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10.0
        
        //default는 content가 왼쪽에 딱 붙어있습니다. leftView에 padding을 넣어 띄워줍니다.
        let PaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftView = PaddingView
        self.leftViewMode = .always
        
        //TextField가 변경될 때 textFieldDidChange()를 호출합니다.
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        //textfield에서 작성 중 일때 x버튼을 활성화합니다.
        self.clearButtonMode = .whileEditing

    }
    
    ///viewDidLoad()의 NotificationObserver가 받는 Notification을 생성합니다.
    ///해당 TextField에 내용이 작성된 경우 "CheckFields", 공란인 경우 "Disable"로 생성합니다.
    @objc func textFieldDidChange(_ textField: UITextField) {
            if let text = textField.text, !text.isEmpty {
                NotificationCenter.default.post(name: Notification.Name("CheckFields"), object: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name("Disable"), object: nil)
            }
        }

    
}

/// UITextField -> defaultTextField -> PassWordTextField
/// 상위 defaultTextField를 상속받은 class 입니다.
/// 오른쪽View에 눈동자 이미지를 추가하여 비밀번호를 보거나 가리게 합니다.
class PassWordTextField : defaultTextField {
    
    var isOpen: Bool = false
    var EyeImage = UIImage(named: "Invisible")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let PaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: self.frame.size.height)) //PaddingView가 rightView에 들어갑니다.
        let RightEyeView = UIView(frame: CGRect(x: 0, y: self.frame.size.height/2 - 10, width: 20, height: 20)) //RightEyeView는 EyeimageView와 패딩을 포함합니다.
        let EyeimageView = UIImageView(frame: RightEyeView.bounds) // EyeimageView는 눈이미지만을 포함합니다.
        
        EyeimageView.image = EyeImage
        EyeimageView.contentMode = .scaleAspectFit
        
        //PaddingView -> RightEyeView -> EyeimageView
        RightEyeView.addSubview(EyeimageView)
        PaddingView.addSubview(RightEyeView)
        
        self.rightView = PaddingView
        self.rightViewMode = .always
            
        ///rightView(눈동자 이미지)에 TapGestuerRecog를 추가합니다.
        ///selector EyeTapped()는 바로 아래 참조
        let EyetapGesture = UITapGestureRecognizer(target: self, action: #selector(EyeTapped))
        self.rightView!.addGestureRecognizer(EyetapGesture)
    }
    
    //EyetapGesture의 selector로 호출되는 함수입니다.
    @objc func EyeTapped() {
        //guard let으로 rightView의 EyeimageView를 불러옵니다.
        guard let eyeImageView = rightView?.subviews.first?.subviews.first as? UIImageView else {
            print("Unintended Error")
                return
            }
            
        //본 class의 isOpen 속성값에 따라 이미지와 .isSecureTextEntry, .isOpen값을 조정합니다.
        if self.isOpen {
            EyeImage = UIImage(named: "Visible")
            eyeImageView.image = EyeImage
            self.isSecureTextEntry = false
            self.isOpen = false
        }
        else {
            EyeImage = UIImage(named: "Invisible")
            eyeImageView.image = EyeImage
            self.isSecureTextEntry = true
            self.isOpen = true
        }
    }
}
