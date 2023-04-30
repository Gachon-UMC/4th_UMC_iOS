// 이거 4주차 프로그래머스 문제입니ㅏㄷ.
let babbling: [String] = ["ayaye", "uuu", "yeye", "yemawoo", "ayaayaa"]

enum pronun: String, CaseIterable {
    case aya
    case ye
    case woo
    case ma
    
    func return_index(_ startIndex: Int) -> Int {
        switch self{
        case .aya, .woo :
            return startIndex+3
        case .ye, .ma :
            return startIndex+2
        }
    }
}

//클로저 필터로 안맞는 것만 거르자
func detecting(_ str_in: String, _ i: Int = 0) {
    var str_a = str_in
    for i in pronun.allCases {
        let proStr = String(describing: i)
        var a_index = str_a.ranges(of: proStr)
        for i in a_index {
            print(str_in[i.lowerBound],str_in[i.upperBound])
        }
        //if let index = str_a.index(str_in.startIndex, offsetBy: 3, limitedBy: str_in.endIndex) {str_in.remove(at: index)}
        
        }
        
    
}

/*
let str = "Hello, playground, playground, playground"
str.index(of: "play")      // 7
str.endIndex(of: "play")   // 11
str.indices(of: "play")    // [7, 19, 31]
str.ranges(of: "play")     // [{lowerBound 7, upperBound 11}, {lowerBound 19, upperBound 23}, {lowerBound 31, upperBound 35}]
*/
detecting("ayaayaayaaya")
