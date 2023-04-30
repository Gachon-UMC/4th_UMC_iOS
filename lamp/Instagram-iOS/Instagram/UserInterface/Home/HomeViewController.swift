//
//  HomeViewController.swift
//  Instagram
//
//  Created by 박민서 on 2023/04/29.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var nav_bar: UINavigationBar!
    @IBOutlet weak var StoryCollectionView: UICollectionView!
    
    
    var story_list: [story] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.StoryCollectionView.delegate = self
        self.StoryCollectionView.dataSource = self
        let nibName = UINib(nibName: "StoryCollectionViewCell", bundle: nil)
                StoryCollectionView.register(nibName, forCellWithReuseIdentifier: "StoryCollectionViewCell")
        
        story_list.append(story("Lamp","DefaultProfile"))
        story_list.append(story("Name1","Image1"))
        story_list.append(story("Name2","Image2"))
        story_list.append(story("Name3","Image3"))
        story_list.append(story("Name4","Image4"))
        story_list.append(story("Name5","Image5"))
        story_list.append(story("Name6","Image6"))
        
        nav_bar.setBackgroundImage(UIImage(), for: .default)
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

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // CollectionView item 개수
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return story_list.count
        }
        
        // CollectionView Cell의 Object
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as! StoryCollectionViewCell
            
            cell.UserImage.image = UIImage(named: story_list[indexPath.row].image) ?? UIImage()
            cell.UserName.text = story_list[indexPath.row].name
            if story_list[indexPath.row].name == "Lamp" {
                cell.plusButton.isHidden = false
            }
            return cell
        }
        
        
        // CollectionView Cell의 Size
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width: CGFloat = collectionView.frame.width/4
            let height: CGFloat = collectionView.frame.height
            return CGSize(width: width, height: height)
        }
        
        // CollectionView Cell의 위아래 간격
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 1.0
        }
        
        // CollectionView Cell의 옆 간격
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1.0
        }
}
