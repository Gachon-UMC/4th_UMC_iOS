var N: Int = 0

while true{
    N = Int(readLine()!)!
    if N >= 1 || N <= 100000{
        break
    }
}

func quickSort(_ array: inout [[Int]], start: Int, end: Int) {
    if start >= end { return } // 원소가 1개인 경우
    
    let pivot = start // 피벗은 첫 요소
    var left = start + 1, right = end
    
    while left <= right {
        // 피벗보다 작은 데이터를 찾을 때까지 반복
        while left <= end && array[left][0] <= array[pivot][0] {
            if array[left][0] == array[pivot][0] && array[left][1] > array[pivot][1] {
                array.swapAt(left, pivot)
            }
            left += 1
        }
        // 피벗보다 큰 데이터를 찾을 때까지 반복
        while right > start && array[right][0] >= array[pivot][0] {
            if array[right][0] == array[pivot][0] && array[right][1] < array[pivot][1] {
                array.swapAt(right, pivot)
            }
            right -= 1
        }
        if left > right { // 엇갈린 경우
            array.swapAt(right, pivot)
        } else { // 엇갈리지 않은 경우
            array.swapAt(right, left)
        }
    }
    // 분할 이후 왼쪽 부분과 오른쪽 부분에서 각각 정렬 수행
    quickSort(&array, start: start, end: right - 1)
    quickSort(&array, start: right + 1, end: end)
}

var co_arr: [[Int]] = []

for i in 0..<N{
    let co_str = readLine()!.split(separator: " ").map{Int($0)!}
    co_arr.append(co_str)
}

quickSort(&co_arr, start: 0, end: N-1)

/* //버블정렬
for z in 0..<2{$
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
}*/



for x in co_arr{
    print(x[0],x[1])
}

//https://www.acmicpc.net/problem/11650
//시간초과-버블정렬
