//
//  ThirdViewController.swift
//  ExpertWorkBook
//
//  Created by 박민서 on 2023/04/29.
//

import Foundation
import UIKit
import Lottie

class ThirdViewController: UIViewController {
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    let animationView = LottieAnimationView(name:"cycling-in-the-park")
    
    let contentArr = [
        "test1", "test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2", "test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3est3test3test3test3test3test3test3test3test3test3test3test3test3test3test3test3","test4","test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5test5"
    ]
    
    var tweet_list: [tweet] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDummydata()
        setCell_resource()
        setDelegate()
        
        refreshControl.tintColor = .clear
        refreshControl.addSubview(animationView)
        
 
        animationView.translatesAutoresizingMaskIntoConstraints = false
        // add horizontal center constraint
        animationView.centerXAnchor.constraint(equalTo: refreshControl.centerXAnchor).isActive = true
        // add vertical center constraint
        animationView.centerYAnchor.constraint(equalTo: refreshControl.centerYAnchor).isActive = true
        // add width constraint
        animationView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        // add height constraint
        animationView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        animationView.frame = refreshControl.bounds
 
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()

        myTableView.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
    }
    
    func addDummydata(){
        tweet_list.append(tweet("ABC","student",contentArr[0]))
        tweet_list.append(tweet("DEF","teacher",contentArr[1]))
        tweet_list.append(tweet("GHI","children",contentArr[2]))
        tweet_list.append(tweet("JKL","lawyer",contentArr[3]))
        tweet_list.append(tweet("MNO","safeguard",contentArr[4]))
    }
    
    func setCell_resource(){
        //Cell 리소스 NIB파일 가져오기
        let myTableViewCellNib = UINib(nibName: String(describing: MyTableViewCell.self), bundle: nil)
        print(myTableViewCellNib)
        //Cell에 리소스 등록 - nib파일의 값을 register
        self.myTableView.register(myTableViewCellNib, forCellReuseIdentifier: "myTableViewCell_ID")
        
        //높이 너비 자동계산
        self.myTableView.rowHeight = UITableView.automaticDimension
        //예상하는 셀 높이 너비를 120으로
        self.myTableView.estimatedRowHeight = 120
    }
    
    func setDelegate(){
        // 아주 중요 결국 delegate패턴이기 때문에 delegate, Datasource를 나 자신으로 연결해줘야 한다.
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
    }
    
}


extension ThirdViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row: \(indexPath.row)")
        
        let alertCon = UIAlertController(title: "선택 셀", message: "선택 셀 인덱스는 \(indexPath.row), \(contentArr[indexPath.row])", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertCon.addAction(okAction)
        present(alertCon,animated: true,completion: nil)
    }
}

extension ThirdViewController: UITableViewDataSource {
    
    //테이블 뷰 셀의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentArr.count
    }
    
    // 각 cell에 대한 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myTableViewCell_ID", for: indexPath) as! MyTableViewCell
        
        cell.userName.text = tweet_list[indexPath.row].name
        cell.userStatus.text = tweet_list[indexPath.row].status
        cell.userContentLabel.text = tweet_list[indexPath.row].text
        
        return cell
    }
}
