//
//  main.swift
//  ProblemSolving_10814
//
//  Created by YOUJIM on 2023/04/28.
//

import Foundation

struct Person {
    var name : String = ""
    var age : Int = 0
    var joinNum : Int = -1
}

var numOfUser = Int(readLine()!)!
var judgeUser = [Person](repeating: Person(), count: numOfUser)

for i in 1...numOfUser {
    let input = readLine()!.components(separatedBy: " ")
    
    judgeUser[i - 1].name = input[1]
    judgeUser[i - 1].age = Int(input[0])!
    judgeUser[i - 1].joinNum = i
}

judgeUser = judgeUser.sorted(by: {
    if $0.age == $1.age { return $0.joinNum < $1.joinNum }
    return $0.age < $1.age
})

for i in 0..<numOfUser {
    print(judgeUser[i].age, judgeUser[i].name)
}

