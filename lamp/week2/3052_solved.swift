var input_list: [Int] = []
for i in 0..<10{
    var input: Int = -1
    while true {
        input = Int(readLine()!)!
        if input <= 1000 && input >= 0{
            break
        }
    }
    input_list.append(input)
}

let remaind_list = input_list.map { $0 % 42 }
let remaind_set = Set(remaind_list)

print(remaind_set.count)

//https://www.acmicpc.net/problem/3052
