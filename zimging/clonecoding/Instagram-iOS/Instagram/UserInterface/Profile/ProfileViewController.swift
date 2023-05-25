//
//  ProfileViewController.swift
//  Instagram
//
//  Created by 서은수 on 2022/09/19.
//

import UIKit

protocol SendDataToEdit {
    func SendDataToE (myName: String, myID: String, myIntro: String, myLink: String)
}

class ProfileViewController: UIViewController, SendDataToProfile {
    func sendDataToP(myName: String, myID: String, myIntro: String, myLink: String) {
        name.text = myName
        id.text = myID
        intro.text = myIntro
        link.text = myLink
    }
    
    var delegate: SendDataToEdit?
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) { }
    
    @IBAction func editBtn(_ sender: Any) {
        performSegue(withIdentifier: "goToEdit", sender: self)
    }
    
    @IBOutlet weak var grid: UIButton!
    @IBOutlet weak var tag: UIButton!
    
    @IBAction func grid(_ sender: Any) {
        grid.tintColor = UIColor.black
        tag.tintColor = UIColor.gray
        gridView.backgroundColor = UIColor.black
        tagView.backgroundColor = UIColor.clear
    }
    
    @IBAction func tag(_ sender: Any) {
        grid.tintColor = UIColor.gray
        tag.setImage(UIImage(systemName: "postGrid"), for: .normal)
        tag.tintColor = UIColor.black
        gridView.backgroundColor = UIColor.clear
        tagView.backgroundColor = UIColor.black
    }
    
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var gridView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var intro: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var link: UILabel!
    
    @IBAction func backToPage(_ sender: UIStoryboardSegue) {
    }
    
    @available(iOS 16.0, *)
    @IBAction func hamburgerBtn(_ sender: Any) {
        let settingVC = SettingViewController()
        settingVC.modalPresentationStyle = .formSheet
        
        if let sheet = settingVC.sheetPresentationController {
            // VC 높이의 60%까지 올려줌
            let multiplier = 0.6
            let fraction = UISheetPresentationController.Detent.custom { context in
                settingVC.view.frame.height * multiplier
            }
            sheet.detents = [fraction]
            // grabber...? 그 회색 위에 있는 조그만 막대 같은 거 표시해줌
            sheet.prefersGrabberVisible = true
            // 중간 이상으로는 스크롤 안되게 막아줌
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        //화면에 뿌려줌
        present(settingVC, animated: true)
    }
    
    @IBAction func addPostBtn(_ sender: Any) {
        let addPostVC = AddPostViewController()
        
        if let sheet = addPostVC.sheetPresentationController {
            // 중간 높이까지만 올려줌
            sheet.detents = [ .medium() ]
            // grabber...? 그 회색 위에 있는 조그만 막대 같은 거 표시해줌
            sheet.prefersGrabberVisible = true
            // 중간 이상으로는 스크롤 안되게 막아줌
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        //화면에 뿌려줌
        present(addPostVC, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEdit" {
            let vc = segue.destination as! EditViewController
            vc.name = name.text!
            vc.id = id.text!
            vc.intro = intro.text!
            vc.link = link.text!
            vc.delegate = self //이건 왜 해주는거지? 중간끝나고 봐야지 -> 위임자를 선택해주는 거라고 함
        }
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UICollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
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
