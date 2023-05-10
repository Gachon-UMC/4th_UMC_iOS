//
//  main.swift
//  ProblemSolving_9012
//
//  Created by YOUJIM on 2023/05/08.
//

import Foundation

for _ in 1...Int(readLine()!)! {
    var testStr = Array(readLine()!)
    var index = 0
    while true {
        if index == testStr.count - 1 || testStr.count == 0 {
            break
        }
        if testStr[index] == "(" && testStr[index + 1] == ")" {
            testStr.remove(at: index + 1)
            testStr.remove(at: index)
            index = 0
        }
        else { index = index + 1 }
    }
    if testStr.contains("(") == true || testStr.contains(")") == true { print("NO") }
    else {print("YES")}
}


