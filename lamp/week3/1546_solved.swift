let N = Int(readLine()!)!
let score_arr = readLine()!.split(separator: " ").map{Int($0)!}
let M = score_arr.max()!
var temp: Float = 0.0

for i in 0..<score_arr.endIndex{
    temp += Float(score_arr[i]) * 100 / Float(M)
}

let result: Float = temp / Float(N)
print(result)
