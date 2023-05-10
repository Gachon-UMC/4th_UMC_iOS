//
//  AddPostViewController.swift
//  Instagram
//
//  Created by YOUJIM on 2023/05/11.
//

import UIKit

class AddPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //릴스 누르면 릴스 출력
    @IBAction func reelsBtn(_ sender: UIButton) {
        print("릴스")
    }
    
    //게시물 누르면 게시물 출력
    @IBAction func postBtn(_ sender: Any) {
        print("게시물")
    }
    
    //스토리 누르면 스토리 출력
    @IBAction func storyBtn(_ sender: Any) {
        print("스토리")
    }
    
    //하이라이트 누르면 스토리 하이라이트 출력
    @IBAction func highlightBtn(_ sender: Any) {
        print("스토리 하이라이트")
    }
    
    //라이브 누르면 라이브 방송 출력
    @IBAction func liveBtn(_ sender: Any) {
        print("라이브 방송")
    }
    
}
