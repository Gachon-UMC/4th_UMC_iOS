import UIKit

class TabBarController: UITabBarController {
    
    static let identifier = "TabBarController"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.unselectedItemTintColor = .black
    }
}
