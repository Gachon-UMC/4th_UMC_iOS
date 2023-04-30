import UIKit

class SubTabBar: UITabBar, UITabBarDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.layer.addBorder([.bottom], color: .black, width: 0.0, name: "initialBorder")
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == items?.first {
            tabBar.layer.sublayers!.last?.removeFromSuperlayer()
            tabBar.layer.addBorder([.bottom], color: UIColor.black, width: 1.0, name: "firstBorder")
        } else {
            tabBar.layer.sublayers!.last?.removeFromSuperlayer()
            tabBar.layer.addBorder([.bottom], color: UIColor.black, width: 1.0, name: "secondBorder")
        }
    }
}
        //tabBar.layer.borderWidth = 1.0
        //tabBar.layer.borderColor = UIColor.red.cgColor
        /*
            guard let items = self.items else { return }
            for index in 0..<items.count {
                let currentItem = items[index]
                if currentItem == item {
                    currentItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 2)
                    currentItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
                } else {
                    currentItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
                    currentItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
                }
            }
         */

    
    /*
    func updateTabBarAppearance() {
            if let items = self.items {
                for item in items.enumerated() {
                    let insets = UIEdgeInsets(top: 0, left: 0, bottom: (item.element == selectedItem) ? 2.0 : 0, right: 0)
                    item.element.imageInsets = insets
                    print("ddd")
                }
            }
        }
        
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            print("selecete")
            updateTabBarAppearance()
        }*/

