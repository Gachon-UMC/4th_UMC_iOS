//
//  APODmodel.swift
//  Practice9-1
//
//  Created by 이재혁 on 2023/06/03.
//

import Foundation
struct APOD: Decodable {
    let title: String
    let date: String
    let explanation: String
    let hdurl: String
    let url: String
}
