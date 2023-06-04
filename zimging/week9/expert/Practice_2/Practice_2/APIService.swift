//
//  APIService.swift
//  Practice_2
//
//  Created by YOUJIM on 2023/06/04.
//

import Foundation

class APIHandler {
    func getNASAData(completion: @escaping (SpaceData) -> ()) {
        let key = "xZDSkTmM1NWpTXnJsNUoZJWQAyBGD2D2rb5EKdvu"
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=\(key)")!
        let requestURL = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let parsedData = try JSONDecoder().decode(SpaceData.self, from: data)
                    completion(parsedData)
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }.resume()
    }
}
