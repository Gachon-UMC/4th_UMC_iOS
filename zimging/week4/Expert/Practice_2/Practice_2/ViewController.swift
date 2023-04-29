//
//  ViewController.swift
//  Practice_2
//
//  Created by YOUJIM on 2023/04/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfPowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indewPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

class nameClass: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UIImageView!
    
}
