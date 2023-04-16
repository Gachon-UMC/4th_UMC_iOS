import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    let number = Int.random(in: 1...10)
    
    var result_val: String = ""

    
    @IBOutlet weak var result: UILabel!
    
    @IBAction func go_back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if number % 2 == 0{
            if result_val == "even" {
                result.text = "정답이야!"
            }else {
                result.text = "오답이야.."
            }
        } else {
            if result_val == "odd" {
                result.text = "정답이야!"
            }else {
                result.text = "오답이야.."
            }
        }
        
        
    }


}

