//
//  main.swift
//  Practice6-1
//
//  Created by 이재혁 on 2023/05/11.
//

import Foundation

let defaultQueue = DispatchQueue.global(qos: .default)
 
defaultQueue.async {
    for i in 1...3{
        print("\(i)😀")
    }
}
defaultQueue.async {
    for i in 1...3{
        print("\(i)👺")
    }
}
 
for i in 90...120{
    print(i)
}


DispatchQueue.global().async {
        for item in 0...10 {
            print("\(item), ⚪️")
        }
}

DispatchQueue.global().async {
        for item in 0...10 {
            print("\(item), ⚫️")
        }
}

DispatchQueue.global().async {
        for item in 0...10 {
            print("\(item), 🔴")
        }
}
