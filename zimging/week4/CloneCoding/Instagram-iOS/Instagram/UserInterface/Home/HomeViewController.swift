//
//  HomeViewController.swift
//  Instagram
//
//  Created by YOUJIM on 2023/04/29.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var models = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    //MARK: - nib파일 등록과 delegate, dataSource 선언
    func setUpTableView() {
        models.append(Model(imagename: "", id: "내 스토리", isWatch: false))
        models.append(Model(imagename: "", id: "name2", isWatch: true))
        models.append(Model(imagename: "", id: "name3", isWatch: true))
        models.append(Model(imagename: "", id: "name4", isWatch: true))
        models.append(Model(imagename: "", id: "name5", isWatch: true))
        models.append(Model(imagename: "", id: "name6", isWatch: true))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "firstCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "firstCollectionTableViewCell") //nib 파일 등록
        tableView.separatorStyle = .none //cell 구분선 없애기
        
    }


}

    //MARK: - 테이블 뷰 구성
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //cell의 갯수 설정
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //cell의 데이터 구성
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCollectionTableViewCell", for: indexPath) as! firstCollectionTableViewCell
        cell.configure(with: models)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { //cell의 높이 설정
        return 120
    }
}

