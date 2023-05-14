//
//  SNS_data.swift
//  ExpertWorkBook
//
//  Created by 박민서 on 2023/04/29.
//

import Foundation

struct tweet {
    let name: String
    let status: String
    let text: String
    
    init(_ name: String, _ status: String, _ text: String) {
        self.name = name
        self.status = status
        self.text = text
    }
}
