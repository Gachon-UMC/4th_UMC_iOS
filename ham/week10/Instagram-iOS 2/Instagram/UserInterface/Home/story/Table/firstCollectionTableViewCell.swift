//
//  firstCollectionTableViewCell.swift
//  Instagram
//
//  Created by 이재혁 on 2023/05/07.
//

import UIKit

protocol firstCollectionTableViewCellDelegate: AnyObject {
    func didTapImageView(with model: Model)
}

class firstCollectionTableViewCell: UITableViewCell {
    
    weak var delegate: firstCollectionTableViewCellDelegate?
    
    func configure(with models: [Model]){
        self.models = models
        collectionView.reloadData()
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    var models = [Model]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        //rearrangeStories() //23.5.19
        // Initialization code
    }

    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "firstCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "firstCollectionViewCell")
        }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
    // 23.5.19 Add method
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let storedData = UserDefaults.standard.data(forKey: "Story_List"), var StoryList = try? JSONDecoder().decode([Model].self, from: storedData) {
            delegate?.didTapImageView(with: StoryList[indexPath.row])
        }
        
        //delegate?.didTapImageView(with: models[indexPath.row])
        
    }
    //------------------23.5.19
    
}


extension firstCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCollectionViewCell", for: indexPath) as! firstCollectionViewCell
        
        //23.5.19 UserDefaults data 불러와서 색깔 바꾸기
        if let storedData = UserDefaults.standard.data(forKey: "Story_List"), var StoryList = try? JSONDecoder().decode([Model].self, from: storedData) {
            cell.configure(with: StoryList[indexPath.row])
        }
        
        //cell.configure(with: models[indexPath.row])
        
        return cell
    }
    
//    func rearrangeStories() { //23.5.19 재정렬
//        let lastViewedIdentifier = UserDefaults.standard.string(forKey: "lastViewed")
//        if let identifier = lastViewedIdentifier, let index = models.firstIndex(where: { $0.userID == identifier }) {
//            let story = models.remove(at: index)
//            models.append(story)
//        }
//        collectionView.reloadData()
//    }
//
//    func storyWasViewed(identifier: String) {
//        UserDefaults.standard.set(identifier, forKey: "lastViewed")
//        rearrangeStories()
//    }
    
    

}

extension firstCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: 20, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 2
//    }
    
}

////23.5.19 extension of UIView
//extension UIView {
//    var parentViewController: UIViewController? {
//        var parentResponder: UIResponder? = self
//        while parentResponder != nil {
//            parentResponder = parentResponder?.next
//            if let viewController = parentResponder as? UIViewController {
//                return viewController
//            }
//        }
//        return nil
//    }
//}
