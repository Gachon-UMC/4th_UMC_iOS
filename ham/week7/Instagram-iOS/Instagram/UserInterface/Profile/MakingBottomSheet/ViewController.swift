//
//  ViewController.swift
//  Instagram
//  바텀시트 (만들기 버튼)
//  Created by 이재혁 on 2023/05/11.
//

import UIKit

// Reels, postGrid, Story, Highlight, Live
struct makeAssets {
    var makeAssetImage: String
    var makeAssetText: String
}

extension makeAssets {
    static var data = [
        makeAssets(makeAssetImage: "Reels", makeAssetText: "릴스"),
        makeAssets(makeAssetImage: "postGrid", makeAssetText: "게시물"),
        makeAssets(makeAssetImage: "Story", makeAssetText: "스토리"),
        makeAssets(makeAssetImage: "Highlight", makeAssetText: "스토리 하이라이트"),
        makeAssets(makeAssetImage: "Live", makeAssetText: "라이브 방송"),
    ]
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MakeBottomSheetTableViewCell", for: indexPath) as! MakeBottomSheetTableViewCell
        
        let target = dataSource[indexPath.row]
        
        let leftImage = UIImage(named: "\(target.makeAssetImage)")
        cell.iconImage?.image = leftImage
        cell.iconText.text = "\(target.makeAssetText)"
        
        return cell
    }
    
    // cell 클릭 시 이벤트(콘솔 출력)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let target = dataSource[indexPath.row]
        print("\(target.makeAssetText)")
    }

    // tableview
    lazy var tableView: UITableView = {
        let view = UITableView()
        //view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    var dataSource = makeAssets.data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "만들기"
        
        tableView.register(UINib(nibName: "MakeBottomSheetTableViewCell", bundle: nil), forCellReuseIdentifier: "MakeBottomSheetTableViewCell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30)
        ])
        
        setupSheet()
        // Do any additional setup after loading the view.
    }
    
    private func setupSheet() {
        //isModalInPresentation = true : sheet가 dismiss되지 않음!!! default는 false
        
        if let sheet = sheetPresentationController {
            /// 드래그 멈추면 그 위치에 멈추는 지점: default는 large()
            //sheet.detents = [.medium(), .large()]
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom { context in
                    return context.maximumDetentValue * 0.5
                }
                ]
            } else {
                // Fallback on earlier versions
            }
            /// 초기화 드래그 위치
            sheet.selectedDetentIdentifier = .medium
            /// sheet
            sheet.largestUndimmedDetentIdentifier = .medium
            /// sheet 위에 grabber 보이도록
            sheet.prefersGrabberVisible = true
            ///
            sheet.delegate = self
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
