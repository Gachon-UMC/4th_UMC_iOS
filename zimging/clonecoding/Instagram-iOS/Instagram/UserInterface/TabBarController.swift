//
//  TabBarController.swift
//  Instagram
//
//  Created by 서은수 on 2022/09/13.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedIndex = 4
        tabBar.unselectedItemTintColor = .black
    }
}
