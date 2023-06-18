import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    let number = Int.random(in: 1...10)
    
    var result_val: String = ""
    var result_data: String = ""

    
    @IBOutlet weak var result: UILabel!
    
    @IBAction func go_back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(handleDataNotification(_:)), name: NSNotification.Name("DataNotification"), object: nil)
    }
    
    @objc func handleDataNotification(_ notification: Notification) {
        if let data = notification.object as? String {
            self.result_data = data
            //print("Received data: \(self.result_data)")
            // 데이터를 사용하여 원하는 작업을 수행합니다.
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("제발..!:\(result_data)")
        
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

