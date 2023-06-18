//
//  MyDB.swift
//  ExpertWorkBook
//
//  Created by 박민서 on 2023/06/16.
//

import RealmSwift

//class ULog: Object {
//    @Persisted var name: String = ""
//    @Persisted var status: String = ""
//    @Persisted var time: Date
//    @Persisted var accessToken: String = ""
//
//    convenience init(name: String, status: String, time: Date, accessToken: String) {
//        self.init()
//        self.name = name
//        self.status = status
//        self.time = time
//        self.accessToken = accessToken
//    }
//}

class TLog: Object {
    @Persisted var name: String = ""
    @Persisted var status: String = ""
    @Persisted var time: Date
    @Persisted var accessToken: String = ""
    
    convenience init(name: String, status: String, time: Date, accessToken: String) {
        self.init()
        self.name = name
        self.status = status
        self.time = time
        self.accessToken = accessToken
    }
}
