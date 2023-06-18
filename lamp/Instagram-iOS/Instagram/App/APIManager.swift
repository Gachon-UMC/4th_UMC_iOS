//
//  APIManager.swift
//  Instagram
//
//  Created by 박민서 on 2023/06/16.
//

import Alamofire

//print(에러) 뱉는 부분을 화면에 오류화면 띄우는 걸로 바꿔보기

///Server의 API 연결을 담당하는 싱글톤 인스턴스입니다.
///POST_SignIn
///POST_LogIn
///PATCH_UserMod
///GET_Post
///GET_Profile
class APIManger {
    // 싱글톤 선언
    static let shared = APIManger()
    private init() {}
    
    // 유저의 로그인 정보는 본 싱글톤에서 관리합니다.
    var userIdx: Int = 0
    var userjwt: String = ""
    
    /// 회원가입 시 호출하는 함수로, 회원가입 정보를 POST합니다.
    func POST_SignIn(userName:String, userId:String, userEmail:String, userPwd:String, _ completion: @escaping (Bool) -> Void) {
        let base_url = "https://umc.ljhhosting.com/api"
        let uri = "/user/join"
        let parameters: Parameters = [  //post의 body입니다.
            "userName" : userName,
            "userId" : userId,
            "userEmail" : userEmail,
            "userPwd" : userPwd
        ]
        let headers: HTTPHeaders = [    //post의 header입니다.
            "Content-Type": "application/json"
        ]
        
        AF.request(base_url+uri,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .responseDecodable(of: SignLogIn_return.self) { response in
            //respeonse를 APIDecodableStructs에서 정의한 객체로 파싱해옵니다.
            switch response.result {
            case .success(let Result):  //.success는 통신성공입니다.
                if Result.result != nil {   //서버에서 처리가 성공하여 결과값이 포함되어 전송되었을 때
                    print("가입 성공", Result)
//                    self.userIdx = Result.result?.userIdx ?? 0
//                    self.userjwt = Result.result?.jwt ?? "" //회원가입 시에는 회원정보를 저장하지 않습니다.
                    completion(true)
                }
                else {  //서버에서 오류를 전송했을 때
                    print("\(Result.returnCode) : \(Result.returnMsg)")
                }
            case .failure(let error):   //.failure는 통신실패입니다.
                print(error.localizedDescription)
            }
        }
    }
    
    /// 로그인 시 호출하는 함수로, 로그인 정보를 POST합니다.
    /// userInfo : 유저 이메일 또는 유저 아이디
    /// userPwd : 유저 비밀번호
    func POST_LogIn(userInfo:String, userPwd:String, _ completion: @escaping (SignLogIn_return?) -> Void) {
        let base_url = "https://umc.ljhhosting.com/api"
        let uri = "/user/login"
        let parameters: Parameters = [ //post의 body입니다.
            "userInfo" : userInfo,
            "userPwd" : userPwd
        ]
        let headers: HTTPHeaders = [ //post의 header입니다.
            "Content-Type": "application/json"
        ]
        
        AF.request(base_url+uri,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .responseDecodable(of: SignLogIn_return.self) { response in
            //respeonse를 APIDecodableStructs에서 정의한 객체로 파싱해옵니다.
            switch response.result {
            case .success(let Result): //.success는 통신성공입니다.
                if Result.result != nil { //서버에서 처리가 성공하여 결과값이 포함되어 전송되었을 때
                    print("로그인 성공", Result)
                    //로그인 정보를 본 싱글톤 객체에 저장합니다.
                    self.userIdx = Result.result?.userIdx ?? 0
                    self.userjwt = Result.result?.jwt ?? ""
                    completion(Result)
                }
                else { //서버에서 오류를 전송했을 때
                    print("\(Result.returnCode) : \(Result.returnMsg)")
                    completion(Result)
                }
            case .failure(let error): //.failure는 통신실패입니다.
                print(error.localizedDescription)
            }
        }
    }
    
    /// 유저 정보 수정 시 호출하는 함수로, 수정한 정보를 PATCH합니다.
    ///userName: 사용자 이름
    ///userId : 유저 인스타 아이디
    ///userIntro: 유저 프로필 소개글
    ///userWebsite : 유저 프로필 웹사이트 링크
    func PATCH_UserMod(userName: String, userId: String, userIntro: String, userWebsite: String, _ completion: @escaping (Bool) -> Void) {
        let base_url = "https://umc.ljhhosting.com/api"
        let uri = "/user/mod"
        let parameters: Parameters = [ //patch의 body입니다.
            "userName" : userName,
            "userId" : userId,
            "userIntro" : userIntro,
            "userWebsite" : userWebsite
        ]
        let headers: HTTPHeaders = [ //patch의 header입니다.
            "Content-Type": "application/json",
            "X-ACCESS-TOKEN": self.userjwt  //현재 유저의 JWT토큰입니다.
        ]
        
        AF.request(base_url+uri,
                   method: .patch,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .responseDecodable(of: ProfileMod_return.self) { response in
            //respeonse를 APIDecodableStructs에서 정의한 객체로 파싱해옵니다.
            switch response.result {
            case .success(let Result): //.success는 통신성공입니다.
                if Result.result != nil { //서버에서 처리가 성공하여 결과값이 포함되어 전송되었을 때
                    print("정보 수정 성공", Result)
                    completion(true)
                }
                else { //서버에서 오류를 전송했을 때
                    print("\(Result.returnCode) : \(Result.returnMsg)")
                }
            case .failure(let error): //.failure는 통신실패입니다.
                print(error.localizedDescription)
            }
        }
    }
    
    /// 홈화면을 Post의 데이터를 받아올 때 호출하는 함수로, GET으로 요청합니다.
    func GET_Post(_ completion: @escaping (GetPosts_return?) -> Void) {
        let base_url = "https://umc.ljhhosting.com/api"
        let uri = "/post/home"

        let headers: HTTPHeaders = [ //get의 header입니다.
            "Content-Type": "application/json",
            "X-ACCESS-TOKEN": self.userjwt //현재 유저의 JWT토큰입니다.
        ]
        
        AF.request(base_url+uri,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .responseDecodable(of: GetPosts_return.self) { response in
            //respeonse를 APIDecodableStructs에서 정의한 객체로 파싱해옵니다.
            switch response.result {
            case .success(let Result): //.success는 통신성공입니다.
                if Result.result != nil { //서버에서 처리가 성공하여 결과값이 포함되어 전송되었을 때
                    print("불러오기 성공", Result)
                    completion(Result)
                }
                else { //서버에서 오류를 전송했을 때
                    print("\(Result.returnCode) : \(Result.returnMsg)")
                }
            case .failure(let error): //.failure는 통신실패입니다.
                print(error.localizedDescription)
            }
        }
    }
    
    func GET_Profile(_ completion: @escaping (GetProfile_result?) -> Void) {
        let base_url = "https://umc.ljhhosting.com/api"
        let uri = "/user/profile"

        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-ACCESS-TOKEN": self.userjwt //현재 유저의 JWT토큰입니다.
        ]
        
        AF.request(base_url+uri,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .responseDecodable(of: GetProfile_return.self) { response in
            //respeonse를 APIDecodableStructs에서 정의한 객체로 파싱해옵니다.
            switch response.result {
            case .success(let Result): //.success는 통신성공입니다.
                if Result.result != nil { //서버에서 처리가 성공하여 결과값이 포함되어 전송되었을 때
                    print("불러오기 성공", Result)
                    completion(Result.result)
                }
                else { //서버에서 오류를 전송했을 때
                    print("\(Result.returnCode) : \(Result.returnMsg)")
                    
                }
            case .failure(let error): //.failure는 통신실패입니다.
                print(error.localizedDescription)
            }
        }
    }
    
    ///예비용
    ///로그아웃 시 JWT파기
    func LogOut() {
        self.userIdx = 0
        self.userjwt = ""
    }
    
}
