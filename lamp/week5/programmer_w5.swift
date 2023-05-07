import Foundation

var survey: [String] = ["TR", "RT", "TR"]
var choices: [Int] = [7, 1, 3]

func solution(_ survey:[String], _ choices:[Int]) -> String {
    var first_Ptype_Dic: [String:Int] = ["R":0,"C":0,"J":0,"A":0]
    var second_Ptype_Dic: [String:Int] = ["T":0,"F":0,"M":0,"N":0]
    var result: String = ""
    
    for i in 0..<survey.count {
        let s_index = survey[i].startIndex
        let e_index = survey[i].index(before: survey[i].endIndex)
        let first_element = survey[i][s_index]
        let second_element = survey[i][e_index]
        
        if choices[i] < 4 { //비동의
            if let _ = first_Ptype_Dic[String(first_element)]{
                first_Ptype_Dic[String(first_element)]! += 4 - choices[i]
            } else {
                second_Ptype_Dic[String(first_element)]! += 4 - choices[i]
            }
        }else if choices[i] > 4 { //동의
            if let _ = second_Ptype_Dic[String(second_element)]{
                second_Ptype_Dic[String(second_element)]! += choices[i] - 4
            } else {
                first_Ptype_Dic[String(second_element)]! += choices[i] - 4
            }
        } else {}
    }
    
    let TestArr1 = ["R","C","J","A"]
    let TestArr2 = ["T","F","M","N"]
    
    for (x,y) in zip(TestArr1,TestArr2) {
        let first_point = first_Ptype_Dic[x]!
        let second_point = second_Ptype_Dic[y]!
        
        if first_point > second_point {
            result.append(x)
        }else if first_point < second_point {
            result.append(y)
        }else {
            result.append(x)
        }
    }
    
    return result
}

let result = solution(survey, choices)
print(result)
