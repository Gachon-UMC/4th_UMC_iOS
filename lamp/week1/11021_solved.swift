let casenum = Int(readLine()!)!
var res_arr: [Int] = []

for i in 0..<casenum {
    var case_text = readLine()!
    var case_arr = case_text.split(separator: " ")
    res_arr.append(Int(case_arr[0])! + Int(case_arr[1])!)
}

for i in 0..<casenum {
    print("Case #\(i+1): \(res_arr[i])")
}
