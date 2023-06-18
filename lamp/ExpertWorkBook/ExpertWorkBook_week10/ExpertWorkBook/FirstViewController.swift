import Foundation
import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var odd_t: UIButton!
    
    @IBOutlet weak var even_t: UIButton!
    
    @IBOutlet weak var doogoo: UILabel!
    
    var val: String = ""
    
    
    @IBAction func odd(_ sender: Any) {
        val = "odd"
        odd_t.layer.cornerRadius = 10.0
        odd_t.backgroundColor = UIColor.systemGray5
        even_t.backgroundColor = UIColor.clear
    }
    
    @IBAction func even(_ sender: Any) {
        val = "even"
        even_t.layer.cornerRadius = 10.0
        odd_t.backgroundColor = UIColor.clear
        even_t.backgroundColor = UIColor.systemGray5
    }
    
    @IBAction func didTapAction(_ sender: Any) {
        
        if let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController {
            
            self.present(secondViewController, animated: true, completion: nil)
            
//            self.doogoo.isHidden = false
//
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    secondViewController.result_val = self.val
//                    self.present(secondViewController, animated: true, completion: nil)
//                    self.doogoo.isHidden = true
//                }
           
        }
        /*
        guard let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {
            return
        }
        secondViewController.result_text = data
        self.present(secondViewController, animated: true, completion: nil)
        */
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        doogoo.isHidden = true
    }


}

