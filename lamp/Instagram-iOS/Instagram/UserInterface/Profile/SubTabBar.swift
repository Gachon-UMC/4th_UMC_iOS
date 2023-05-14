import UIKit

class SubTabBar: UITabBar, UITabBarDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.layer.addBorder([.bottom], color: .black, width: 0.0, name: "initialBorder")
        self.tabBar(self, didSelect: self.items!.first!)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == items?.first {
            //item.image?.withTintColor(UIColor.black)
            tabBar.layer.sublayers!.last?.removeFromSuperlayer()
            tabBar.layer.addBorder([.bottom], color: UIColor.black, width: 1.0, name: "firstBorder")
        } else {
            //item.image?.withTintColor(UIColor.black)
            tabBar.layer.sublayers!.last?.removeFromSuperlayer()
            tabBar.layer.addBorder([.bottom], color: UIColor.black, width: 1.0, name: "secondBorder")
        }
    }
}

