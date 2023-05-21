let input = "23four5six7"

enum Nums: Int, CaseIterable{
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    
    var description:String {
        return "\(self)"
    }
}

var Number_list: [Number] = []

struct Number {
    var Num: String
    var upperbound: String.Index
    
    init(Num: String, upperbound: String.Index) {
        self.Num = Num
        self.upperbound = upperbound
    }
}

for num in Nums.allCases { //Nums의 모든 case 순회
    let numStr = num.description //Nums case의 case이름 가져오기
    let numVal = String(num.rawValue)
    let ranges_Str = input.ranges(of: numStr)
    let ranges_Int = input.ranges(of: numVal)
    
    for i in ranges_Str {
         let Num_instance = Number(Num: numVal, upperbound: i.upperBound)
         Number_list.append(Num_instance)
     }
    for i in ranges_Int {
        let Num_instance = Number(Num: numVal, upperbound: i.upperBound)
        Number_list.append(Num_instance)
    }
 }

let sortedNumList = Number_list.sorted {$0.upperbound < $1.upperbound }
var ResultStringList = sortedNumList.map{ $0.Num }
let Result = Int(ResultStringList.joined())!

print(Result)

/*  프로그래머스에서 ranges가 없어서 작성
 extension String {

     /// Finds and returns the ranges of all occurrences of a given string
     /// within the string.
     /// - Parameter string: The string to search for.
     /// - Returns: An array of ranges of all occurrences of `string`. Returns
     ///  an empty array if `string` is not found.
     func ranges(of string: String) -> [Range<String.Index>] {
         var ranges: [Range<String.Index>] = []
         var startIndex = self.startIndex

         while startIndex < self.endIndex,
               let range = self[startIndex...]
                   .range(of: string, options: .literal)
         {
             ranges.append(range)
             startIndex = range.upperBound
         }

         return ranges
     }
 }
 */


//정석
/*
 
 import Foundation

 func solution(_ s:String) -> Int {
     let arr = ["zero","one","two","three","four","five","six","seven","eight","nine"]
     var str = s
     for i in 0..<arr.count {
         str = str.replacingOccurrences(of: arr[i], with: String(i))
            //let arr = ["zero","one","two","three","four","five","six","seven","eight","nine"]
     }
     return Int(str)!
 }

 print(solution("one4seveneight"))

 */
