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

//print(seq_arr) // >여기까지 xy좌표 어레이로 받은거

var set_list: [[Set<Int>]] = []
set_list.append([[0]])
set_list.append([[0]])

for i in 0..<count{
    let x = seq_arr[i][0]
    let y = seq_arr[i][1]
    var x_Set = Set<Int>()
    var y_Set = Set<Int>()
    
    for xval in x...x+10{
        x_Set.insert(xval)
    }
    for yval in y...y+10{
        y_Set.insert(yval)
    }
    
    set_list[0].append(x_Set)
    set_list[1].append(y_Set)
}



var area_sub: Int = 0

for i in 1..<set_list[0].endIndex {
    for u in i+1..<set_list[0].endIndex {
        let inter_x = set_list[0][i].intersection(set_list[0][u]).sorted()
        let inter_y = set_list[1][i].intersection(set_list[1][u]).sorted()
        print("inter_x: ",inter_x)
        print("Inter_y: ",inter_y)
        
        if inter_x.isEmpty || inter_y.isEmpty {
            continue
        } else{
            let x = inter_x[inter_x.endIndex-1] - inter_x[0]
            let y = inter_y[inter_y.endIndex-1] - inter_y[0]
            print("x: ",x,"y: ",y)
            area_sub += x*y
        }
    }
}
func area_cal([[Set<Int]]){
    
}
area_sub = area_cal(set_list)
//이 +-해주는 부분을 해결해야함 > 함수로 만들어 해결해보자
print(10*10*count - area_sub)


/* // 애매하게하다가 실패한 부분
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

print(sub_area_arr) */

//https://www.acmicpc.net/problem/2563
