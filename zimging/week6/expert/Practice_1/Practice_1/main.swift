//
//  main.swift
//  Practice_1
//
//  Created by YOUJIM on 2023/05/10.
//

import Foundation

let serialQueue = DispatchQueue.init(label: "serialQueue")

for i in 1...10 {
    serialQueue.sync {
        Thread.sleep(forTimeInterval: 1)
        print("\(i)")
    }
}

let concurrentQueue = DispatchQueue.init(label: "concurrentQueue", attributes: .concurrent)

for i in 1...5 {
    concurrentQueue.sync {
        Thread.sleep(forTimeInterval: 1)
        print("\(i)")
    }
}

let globalQueue = DispatchQueue.global()

for i in 1...15 {
    globalQueue.sync {
        Thread.sleep(forTimeInterval: 1)
        print("\(i)")
    }
}

let mainQueue = DispatchQueue.main

for i in 1...5 {
    mainQueue.async {
        print("\(i)")
    }
}
