import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

func fetchDataAndDecode() {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") else {
        print("Invalid URL")
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("Error fetching data: \(error)")
            return
        }
        
        
        guard let data = data else {
            print("No data received")
            return
        }
        
        
        do {
            let decoder = JSONDecoder()
            let post = try decoder.decode(Post.self, from: data)
            print(post)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    task.resume()
}

// 함수 호출
fetchDataAndDecode()
