var N: Int = 0

while true{
    N = Int(readLine()!)!
    if N >= 1 || N <= 100000{
        break
    }
}

var co_arr: [[Int]] = []

for i in 0..<N{
    let co_str = readLine()!.split(separator: " ").map{Int($0)!}
    co_arr.append(co_str)
}

for z in 0..<2{
    for i in 0..<N{
        for u in i..<N-1{
            if co_arr[u][0] > co_arr[u+1][0] {
                co_arr.swapAt(u, u+1)
            } else if co_arr[u][0] == co_arr[u+1][0] {
                if co_arr[u][1] > co_arr[u+1][1] {
                    co_arr.swapAt(u, u+1)
                }
            }
        }
    }
}

for x in co_arr{
    print(x[0],x[1])
}

//https://www.acmicpc.net/problem/11650
//시간초과
