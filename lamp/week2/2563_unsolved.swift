var count: Int = 0

while true {
    count = Int(readLine()!)!
    if count <= 100 && count >= 1 {
        break
    }
}

var seq_arr: [[Int]] = []

for i in 0..<count {
    let input: String = readLine()!
    let input_arr = input.split(separator: " ").map{Int($0)!}
    seq_arr.append(input_arr)
}

var sub_area_arr: [Int] = []

for i in seq_arr.startIndex..<seq_arr.endIndex{
    for u in i+1..<seq_arr.endIndex{
        let x_sub = abs(seq_arr[i][0] - seq_arr[u][0])
        let y_sub = abs(seq_arr[i][1] - seq_arr[u][1])

        if x_sub < 10 {
            if y_sub < 10 {
                //여기에 겹친 넓이를 구해야해 첫번째 i 두번째 u
                if seq_arr[i][0] < seq_arr[u][0]{
                    var x_s = seq_arr[i][0] + x_sub
                    var y_s = seq_arr[][] //y좌표 어떻게 설정할건지
                } else if seq_arr[i][0] > seq_arr[u][0] {
                    
                } else {
                    
                }
                
            }
        }
        
        
        
        
    }
    
}

print(sub_area_arr)

//https://www.acmicpc.net/problem/2563
