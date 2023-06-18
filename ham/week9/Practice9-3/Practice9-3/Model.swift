//
//  Model.swift
//  Practice9-3
//
//  Created by 이재혁 on 2023/06/09.
//

import Foundation
struct TourData: Codable {
    var comMsgHeader: TourComHeader
    var msgHeader: TourMsgHeader
    var msgBody: [TourBody]
}

struct TourComHeader: Codable {
    var successYN: String
    var returnCode: String
    var returnMessage: String
}

struct TourMsgHeader: Codable {
    var pageNo: Int
    var totalCount: Int
    var totalPage: Int
    var numOfRows: Int
}

struct TourBody: Codable {
    var tourSeq: String
    var id: String
    var name: String
    var recommend: String
    var expression: String
    var dCode: String?
    var tGubun: String?
    var pGubun: String?
    var lGubun: String?
    var cGubun: String?
    var sGubun: String?
    var addr1: String
    var addr2: String?
    var zipcode: String?
    var nAddr1: String?
    var nAddr2: String?
    var telCode: String
    var telKuk: String
    var telNo: String
    var hitCnt: String
    var dTag: String?
    var dTel: String?
    var idxImgPath: String?
    var idxImgName: String?
    var dCodeNm: String?
    var contents2: String?
    var imgIdx: String?
    var keyword: String?
    var useYn: String
    var dLang: String
    var cid: String?
}
