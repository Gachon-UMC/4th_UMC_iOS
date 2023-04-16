//
//  main.swift
//  ProblemSolving_2439
//
//  Created by YOUJIM on 2023/04/15.
//

import Foundation

let n = Int(readLine()!)!

for i in 1...n {
    var temp = 0
    for _ in 0..<n-i {
        print(" ", terminator: "")
    }
    for _ in n-i..<n {
        print("*", terminator: "")
    }
    print("")
}
