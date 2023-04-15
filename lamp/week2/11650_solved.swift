let N = Int(readLine()!)!
var co_dict: [Int : [Int] ] = [:]

for i in 0..<N{
    let input = readLine()!.split(separator: " ").map{Int($0)!}
    
    if co_dict[input[0]] == nil {
        co_dict[input[0]] = []
    } // 해당 key와 value가 존재하는지 확인해줘야 함. nil인경우 array만들어주기
    
    co_dict[input[0]]!.append(input[1])
}

for x in co_dict.keys.sorted(){
    for y in co_dict[x]!.sorted(){
        print(x,y)
    }
 }

//https://www.acmicpc.net/problem/11650
//시간초과-버블정렬 배열정렬알고리즘 컷 - 딕셔너리와 sorted()메소드 (복잡도 O(nlogn) 사용
