//
//  StoryTableViewCell.swift
//  Instagram
//
//  Created by 박민서 on 2023/05/07.
//

import UIKit

class StoryTableViewCell: UITableViewCell {
    @IBOutlet weak var CollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerXib()
        registerDelegate()
        self.layer.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0, set: "Normal")
    }
    
    private func registerXib(){
        
        let firststoryNib = UINib(nibName: "FirstCollectionViewCell", bundle: nil)
        CollectionView.register(firststoryNib, forCellWithReuseIdentifier: "FirstCollectionViewCell")
        let storyNib = UINib(nibName: "StoryCollectionViewCell", bundle: nil)
        CollectionView.register(storyNib, forCellWithReuseIdentifier: "StoryCollectionViewCell")
        
    }
    
    private func registerDelegate() {
        CollectionView.delegate = self
        CollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension StoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return story_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as? StoryCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.item == 0 {
                    // 첫 번째 셀에 대한 특별한 처리를 수행합니다.
                    let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
                    firstCell.UserImage.image = UIImage(named: story_list[indexPath.row].image) ?? UIImage()
            firstCell.UserImage.contentMode = .scaleAspectFill
                    firstCell.UserName.text = story_list[indexPath.row].name
                    //firstCell.layer.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0)
                    return firstCell
                }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as! StoryCollectionViewCell
            cell.UserImage.image = UIImage(named: story_list[indexPath.row].image) ?? UIImage()
            //print(cell.UserImage.image)
            cell.UserName.text = story_list[indexPath.row].name
            //print(cell.UserName.text)
            return cell
        }
    }
}
