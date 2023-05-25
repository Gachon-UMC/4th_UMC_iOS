//
//  SettingViewController.swift
//  Instagram
//
//  Created by YOUJIM on 2023/05/11.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //설정 누르면 출력
    @IBAction func settingBtn(_ sender: Any) {
        print("설정")
    }
    
    //활동 누르면 출력
    @IBAction func activityBtn(_ sender: Any) {
        print("내 활동")
    }
    
    //보관 누르면 출력
    @IBAction func saveBtn(_ sender: Any) {
        print("보관")
    }
    
    //큐알 누르면 출력
    @IBAction func qrBtn(_ sender: Any) {
        print("QR 코드")
    }
    
    //저장됨 누르면 출력
    @IBAction func savedBtn(_ sender: Any) {
        print("저장됨")
    }
    
    //디지털 자산 누르면 출력
    @IBAction func assetBtn(_ sender: Any) {
        print("디지털 자산")
    }
    
    //친친 누르면 출력
    @IBAction func closeFriendBtn(_ sender: Any) {
        print("친한 친구")
    }
    
    //즐겨찾기 누르면 출력
    @IBAction func starBtn(_ sender: Any) {
        print("즐겨찾기")
    }
    
    //코로나 누르면 출력
    @IBAction func coronaBtn(_ sender: Any) {
        print("코로나19 정보 센터")
    }
    
}
