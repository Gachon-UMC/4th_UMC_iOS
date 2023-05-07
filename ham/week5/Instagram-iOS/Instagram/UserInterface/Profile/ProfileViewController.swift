//
//  ProfileViewController.swift
//  Instagram
//
//  Created by 서은수 on 2022/09/19.
//

import UIKit

struct Test {
    var image: String
}

extension Test {
    static var data = [
        Test(image: "myPost1"),
        Test(image: "myPost2"),
        Test(image: "myPost3"),
        Test(image: "myPost4"),
    ]
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let collectionViewWidth = collectionView.bounds.width
                let cellItemForRow: CGFloat = 3
                let minimumSpacing: CGFloat = 2
                
                let width = (collectionViewWidth - (cellItemForRow - 1) * minimumSpacing) / cellItemForRow
                
                return CGSize(width: width, height: width)
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 2
            }
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 2
            }
}

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, SendStringData {
    
    // postGrid, tag
    @IBOutlet weak var postGrid: UIButton!
    @IBOutlet weak var tag: UIButton!
    @IBOutlet weak var postGridView: UIView!
    @IBOutlet weak var tagView: UIView!
    
    
    @IBAction func postGrid(_ sender: Any) {
        postGrid.tintColor = UIColor.black
        tag.tintColor = UIColor.gray
        postGridView.backgroundColor = UIColor.black
        tagView.backgroundColor = UIColor.clear
    }
    @IBAction func tag(_ sender: Any) {
        postGrid.tintColor = UIColor.gray
        tag.tintColor = UIColor.black
        postGridView.backgroundColor = UIColor.clear
        tagView.backgroundColor = UIColor.black
    }
    
    
    
    
    let testList = Test.data
    let cellName = "TestListCell"
    let cellReuseIdentifier = "testCell"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        testList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as?
                TestListCell else {
            return UICollectionViewCell()
        }
        let target = testList[indexPath.row]
        
        let img = UIImage(named: "\(target.image).png")
        cell.testImage?.image = img
        
        return cell
    }
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func sendData(mydata: String, myUserName: String, myIntro: String) {
        nameText.text = mydata
        userNameText.text = myUserName
        introText.text = myIntro
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        postGridView.backgroundColor = UIColor.black
        tagView.backgroundColor = UIColor.clear
        
        registerXib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: cellName, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var introText: UILabel!
    @IBOutlet weak var userNameText: UILabel!
    
    var linkTitle = ""
    
    @IBAction func linkText(_ sender: UIButton) {
        //guard let linkButtonText = sender.title(for: .normal) else {return}
        linkTitle = sender.currentTitle!
    }
    @IBAction func ToProfileEdit(_ sender: UIButton) {
        self .performSegue(withIdentifier: "ProfileEdit", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileEdit" {
            let vc = segue.destination as! ProfileEditViewController
            vc.name = nameText.text!
            vc.userName = userNameText.text!
            vc.introduction = introText.text!
            vc.link = linkTitle
            vc.delegate = self
        }
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
