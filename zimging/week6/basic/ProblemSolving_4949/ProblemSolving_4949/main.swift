//
//  main.swift
//  ProblemSolving_4949
//
//  Created by YOUJIM on 2023/05/10.
//

import Foundation

func deleteChar(str: [Character]) -> [Character] {
    var temp = str
    var i = 0
    
    while true {
        if i == temp.count { break }
        if temp[i] == "(" || temp[i] == ")" || temp[i] == "[" || temp[i] == "]" { i = i + 1 }
        else {
            temp.remove(at: i)
            i = 0
        }
    }
    return temp
}

while true {
    var sentenceArr = Array(readLine()!)
    
    if String(sentenceArr) == "." { break }
    
    sentenceArr = deleteChar(str: sentenceArr)
    var index = 0
    
    while true {
        if index == sentenceArr.count - 1 || sentenceArr.count == 0 {
            break
        }
        if (sentenceArr[index] == "(" && sentenceArr[index + 1] == ")") || (sentenceArr[index] == "[" && sentenceArr[index + 1] == "]") {
            sentenceArr.remove(at: index + 1)
            sentenceArr.remove(at: index)
            index = 0
        }
        else { index = index + 1 }
    }
    if sentenceArr.contains("(") == true || sentenceArr.contains(")") == true || sentenceArr.contains("[") == true || sentenceArr.contains("]") == true{ print("no") }
    else {print("yes")}
}

