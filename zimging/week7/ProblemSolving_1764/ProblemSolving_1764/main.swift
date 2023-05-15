//
//  main.swift
//  ProblemSolving_1764
//
//  Created by YOUJIM on 2023/05/16.
//

import Foundation

var notListen = Set<String>()
var notWatch = Set<String>()

var input = readLine()!.components(separatedBy: " ").map {Int($0)!}

for _ in 1...input[0] { notListen.insert(readLine()!) }
for _ in 1...input[1] { notWatch.insert(readLine()!) }

var notListenWatch = notListen.intersection(notWatch).sorted()

print(notListenWatch.count)
for element in notListenWatch { print(element) }

