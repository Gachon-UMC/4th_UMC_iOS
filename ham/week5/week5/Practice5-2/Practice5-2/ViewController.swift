//
//  ViewController.swift
//  Practice5-2
//
//  Created by 이재혁 on 2023/05/04.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataList: [String] = ["a", "b", "c", "d", "e"]
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        assignDelegate()
        initRefresh()
    }

    func initRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        
        refreshControl.backgroundColor = .yellow
        refreshControl.tintColor = .purple
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshTable(refresh: UIRefreshControl) {
        print("새로고침 시작")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tableView.reloadData()
            refresh.endRefreshing()
        }
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "TableViewCell")
    }
    
    private func assignDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else {return UITableViewCell()}
        
        
        return tableCell
    }
}
