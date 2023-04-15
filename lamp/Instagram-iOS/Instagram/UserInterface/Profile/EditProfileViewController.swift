//
//  EditProfile.swift
//  Instagram
//
//  Created by 박민서 on 2023/04/16.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var bar1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bar1.layer.borderWidth = 1
        bar1.layer.borderColor = UIColor.systemGray5.cgColor
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
