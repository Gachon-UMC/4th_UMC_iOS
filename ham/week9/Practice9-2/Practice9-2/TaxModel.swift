//
//  TaxModel.swift
//  Practice9-2
//
//  Created by 이재혁 on 2023/06/03.
//

import Foundation

struct top: Codable {
    let message: message
}

struct message: Codable {
    let result: result
}

struct result: Codable {
    let srcLangType: String
    let tarLangType: String
    let translatedText: String
}
