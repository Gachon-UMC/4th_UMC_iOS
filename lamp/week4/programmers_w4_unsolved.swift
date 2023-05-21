import Foundation

func solution(_ babbling:[String]) -> Int {
    
    var babbling_copy:[String] = babbling.map{$0}
    let bab_words:[String] = ["aya", "ye", "woo", "ma"]
    
    
    for i in babbling_copy.indices {
        for word in bab_words {
            if let range = babbling_copy[i].range(of: word){
                babbling_copy[i].removeSubrange(range)
            }
        }
    }
        
    var result: Int = 0
    for element in babbling_copy {
        if element.isEmpty {
            result += 1
        }
    }
    return result
}

print(solution(["ayaye", "uuu", "yeye", "yemawoo", "ayaayaa"]))

/*
 네 가지 발음과 네 가지 발음을 조합해서 만들 수 있는 발음밖에 하지 못하고 연속해서 같은 발음을 하는 것을 어려워합니다.
 = 연속 안되면 가능 ex) yewooye
 */
