//
//  ViewController.swift
//  Standard_1
//
//  Created by YOUJIM on 2023/04/29.
//

import UIKit

struct Model {
    let name : String
    let org : String
    let color : UIColor
}

class ViewController: UIViewController {
    
    var models = [Model(name: "Zimging", org: "Gachon", color: UIColor.systemCyan), Model(name: "Ham", org: "Gachon", color: UIColor.yellow), Model(name: "Lamp", org: "Gachon", color: UIColor.green), Model(name: "Seori", org: "Gachon", color: UIColor.blue)]

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        collectionView.dataSource = self
        tableView.delegate = self
        
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
                tableView.register(nibName, forCellReuseIdentifier: "Cell")
        
        let nibName2 = UINib(nibName: "CollectionViewCell", bundle: nil)
                collectionView.register(nibName2, forCellWithReuseIdentifier: "collectionCell")
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.nameLabel.text = models[indexPath.row].name
        cell.orgLabel.text = models[indexPath.row].org
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        
        cell.colorField.backgroundColor = models[indexPath.row].color
        
        return cell
    }
    
    
}
