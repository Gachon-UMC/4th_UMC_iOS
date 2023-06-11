//
//  ViewController.swift
//  Standard_2
//
//  Created by YOUJIM on 2023/06/09.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        print("1")
        
        let article = articles[indexPath.row]
        cell.textLabel!.text = article.title
        print(article.title)
        
        return cell
    }

    @IBOutlet weak var newsList: UITableView!
    
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNews()
    }
    
    func fetchNews() {
        let urlString = "https://newsapi.org/v2/top-headlines?country=kr&apiKey=75c9a397ffa14b8694f458a03c5342cf"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching news: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(NewsResponse.self, from: data)
                self.articles = response.articles
                print(self.articles)
                DispatchQueue.main.async {
                    self.newsList.reloadData()
                }
            } catch {
                print("Error decoding news data: \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct NewsResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    // Add other properties as needed
}

