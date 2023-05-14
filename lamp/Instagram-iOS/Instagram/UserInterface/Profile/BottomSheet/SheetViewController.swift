//
//  SheetViewController.swift
//  Instagram
//
//  Created by 박민서 on 2023/05/11.
//

import UIKit

/*
 Bottom Sheet에서 사용된 UISheetPresentationController.detends.custom은 iOS 16.0 이후부터 지원되는 기능입니다.
 해당 Controller는 iOS 16.0 이후부터 적상 작동합니다
 */

@available(iOS 16.0, *)
class SheetViewController: UIViewController, UISheetPresentationControllerDelegate {
    
    @IBOutlet weak var BottomTable: UITableView! //Sheet의 TableView
    
    let Device_height = UIScreen.main.bounds.size.height // 사용 기기의 스크린 높이
    
    var BottomSheetItem: [Bottom_Cell_Data] = [] //BottomSheet에 들어갈 TableViewCellItems 리스트
    var Option: String = "" //ProfileViewController에서 받아오는, "AddPost"인지 "Option"인지 확인
    
    
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    } //UISheetPresentationController 타입으로 형변환된 sheetPresentationController 프로퍼티를 반환해준다 >> 후술되는 detent와 sheetPresentationController의 설정을 잡아주기 위해 사용
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BottomSheetItem = ReturnBottomCellItems(Option) // ProfileView_Data.swift에서 Option 값에 따른 Cell item 목록들을 가져옴
        //print(Device_height) //14pro 852, 8 667
        let bottomSheetHeightConstant = 852/Device_height //852 = 14pro's DeviceHeight
        
        sheetPresentationController.prefersGrabberVisible = true //make Grabber available
        // ProfileView의 tap Action에서 넘겨준 option값에 따라 BottomSheet의 높이 조절
        if Option == "AddPost" {
            sheetPresentationController.detents = [.custom{ context in
                return context.maximumDetentValue * 0.5 * bottomSheetHeightConstant }]  // detent를 custom으로 전체 높이의 0.5만큼
        } else if Option == "Option" {
            sheetPresentationController.detents = [.custom{ context in
                return context.maximumDetentValue * 0.7 * bottomSheetHeightConstant }] // detent를 custom으로 전체 높이의 0.7만큼
        }
        
        
        self.BottomTable.delegate = self //TableView delegate
        self.BottomTable.dataSource = self //TableView datasource
        
        let Make = UINib(nibName: "MAKETableViewCell", bundle: nil) //'만들기' title Cell register
        BottomTable.register(Make, forCellReuseIdentifier: "MAKETableViewCell")
        let Cell = UINib(nibName: "BottomSheetTableViewCell", bundle: nil) // BottomSheet TableView Cell register
        BottomTable.register(Cell, forCellReuseIdentifier: "BottomSheetTableViewCell")
    }
}

@available(iOS 16.0, *)
extension SheetViewController : UITableViewDelegate {
    // Cell의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

@available(iOS 16.0, *)
extension SheetViewController : UITableViewDataSource {
    // ProfileView의 tap Action에서 넘겨준 option값에 따라 BottomSheet의 Cell 개수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Option == "AddPost" {
            return BottomSheetItem.count + 1 // "AddPost"의 경우 "만들기"-title Cell추가로 +1 해줌
        } else {
            return BottomSheetItem.count
        }
    }
    
    
    // "AddPost"의 "만들기"-title Cell 추가로 인해 Option분기별 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Option == "AddPost" && indexPath.item == 0 { //"AddPost를 눌러 BottomSheet를 열었을 때 맨 첫번째 Cell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MAKETableViewCell", for: indexPath) as? MAKETableViewCell else { return UITableViewCell() }
            cell.layer.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0) // Cell의 아랫테두리 설정
            return cell //MAKE Cell return
        } else if Option == "AddPost"{ //"AddPost를 눌러 BottomSheet를 열었을 때 첫번째 Cell제외한 Cell들
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BottomSheetTableViewCell", for: indexPath) as? BottomSheetTableViewCell else { return UITableViewCell() } // this is BottomSheetTableViewCell, will load its data from BottomSheetItem List
            cell.BottomSheetTableCellImage.image = UIImage(named: BottomSheetItem[indexPath.row-1].CellImage) ?? UIImage() //Cell의 아이콘 이미지 설정
            cell.BottomSheetTableCellLabel.text = BottomSheetItem[indexPath.row-1].CellText //Cell의 LabelText 설정
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BottomSheetTableViewCell", for: indexPath) as? BottomSheetTableViewCell else { return UITableViewCell() } // this is BottomSheetTableViewCell, will load its data from BottomSheetItem List
            cell.BottomSheetTableCellImage.image = UIImage(named: BottomSheetItem[indexPath.row].CellImage) ?? UIImage()
            cell.BottomSheetTableCellLabel.text = BottomSheetItem[indexPath.row].CellText
                return cell
            }
        }
}
