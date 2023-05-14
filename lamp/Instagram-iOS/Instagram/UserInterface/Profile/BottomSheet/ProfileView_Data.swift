//
//  ProfileView_Data.swift
//  Instagram
//
//  Created by 박민서 on 2023/05/11.
//

import Foundation

struct Bottom_Cell_Data {
    let CellImage: String
    let CellText: String
    
    init(_ CellImage: String, _ CellText: String) {
        self.CellImage = CellImage
        self.CellText = CellText
    }
}

func ReturnBottomCellItems(_ option: String) -> [Bottom_Cell_Data] {
    var Bottom_Cell_List:[Bottom_Cell_Data] = []
    switch option {
    case "AddPost" : // AddPost일 때 items
        Bottom_Cell_List.append(Bottom_Cell_Data("Reels","릴스"))
        Bottom_Cell_List.append(Bottom_Cell_Data("postGrid","게시물"))
        Bottom_Cell_List.append(Bottom_Cell_Data("Story","스토리"))
        Bottom_Cell_List.append(Bottom_Cell_Data("Highlight","스토리 하이라이트"))
        Bottom_Cell_List.append(Bottom_Cell_Data("Live","라이브 방송"))
    case "Option" : // Option일 때 items
        Bottom_Cell_List.append(Bottom_Cell_Data("Settings","설정"))
        Bottom_Cell_List.append(Bottom_Cell_Data("MyActivity","내 활동"))
        Bottom_Cell_List.append(Bottom_Cell_Data("Storage","보관"))
        Bottom_Cell_List.append(Bottom_Cell_Data("QRCode","QR 코드"))
        Bottom_Cell_List.append(Bottom_Cell_Data("Saving","저장됨"))
        Bottom_Cell_List.append(Bottom_Cell_Data("DigitalAsset","디지털 자산"))
        Bottom_Cell_List.append(Bottom_Cell_Data("CloseFriend","친한 친구"))
        Bottom_Cell_List.append(Bottom_Cell_Data("Star","즐겨찾기"))
        Bottom_Cell_List.append(Bottom_Cell_Data("CoronaInfo","코로나19 정보 센터"))
    default : //예외의 경우
        print("잘못된 옵션")
        return Bottom_Cell_List
    }
    return Bottom_Cell_List
}
