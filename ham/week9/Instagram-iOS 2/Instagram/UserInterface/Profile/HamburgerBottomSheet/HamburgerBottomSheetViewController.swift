//
//  HamburgerBottomSheetViewController.swift
//  Instagram
//
//  Created by 이재혁 on 2023/05/11.
//

import UIKit

struct HamburgerAssets {
    var HamburgerAssetImage: String
    var HamburgerAssetText: String
}

extension HamburgerAssets {
    static var data = [
        HamburgerAssets(HamburgerAssetImage: "Settings", HamburgerAssetText: "설정"),
        HamburgerAssets(HamburgerAssetImage: "MyActivity", HamburgerAssetText: "내 활동"),
        HamburgerAssets(HamburgerAssetImage: "Storage", HamburgerAssetText: "보관"),
        HamburgerAssets(HamburgerAssetImage: "QRCode", HamburgerAssetText: "QR 코드"),
        HamburgerAssets(HamburgerAssetImage: "Saving", HamburgerAssetText: "저장됨"),
        HamburgerAssets(HamburgerAssetImage: "DigitalAsset", HamburgerAssetText: "디지털 자산"),
        HamburgerAssets(HamburgerAssetImage: "CloseFriend", HamburgerAssetText: "친한 친구"),
        HamburgerAssets(HamburgerAssetImage: "Star", HamburgerAssetText: "즐겨찾기"),
        HamburgerAssets(HamburgerAssetImage: "CoronaInfo", HamburgerAssetText: "코로나19 정보 센터"),
    ]
}

class HamburgerBottomSheetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HamburgerBottomSheetTableViewCell", for: indexPath) as! HamburgerBottomSheetTableViewCell
                
                let target = dataSource[indexPath.row]
                
                let leftImage = UIImage(named: "\(target.HamburgerAssetImage)")
                cell.iconImage?.image = leftImage
                cell.iconText.text = "\(target.HamburgerAssetText)"
                
                return cell
    }
    
    // cell 클릭 시 이벤트(콘솔 출력)
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let target = dataSource[indexPath.row]
            print("\(target.HamburgerAssetText)")
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
    
    var dataSource = HamburgerAssets.data

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
                
        tableView.register(UINib(nibName: "HamburgerBottomSheetTableViewCell", bundle: nil), forCellReuseIdentifier: "HamburgerBottomSheetTableViewCell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor)//, constant: 15)
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
                        return context.maximumDetentValue * 0.8
                    }
                    ]
                } else {
                    // Fallback on earlier versions
                }
                /// 초기화 드래그 위치
                sheet.selectedDetentIdentifier = .medium
                /// sheet
                sheet.largestUndimmedDetentIdentifier = .medium
                ///
                sheet.prefersGrabberVisible = true
                ///
                sheet.delegate = self
                ///
                sheet.presentingViewController.navigationController?.setNavigationBarHidden(true, animated: false)

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
