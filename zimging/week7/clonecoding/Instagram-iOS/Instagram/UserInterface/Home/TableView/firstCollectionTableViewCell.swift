//
//  firstCollectionTableViewCell.swift
//  Instagram
//
//  Created by YOUJIM on 2023/04/29.
//

import UIKit

class firstCollectionTableViewCell: UITableViewCell {

    func configure(with models: [Model]){
        self.models = models
        collectionView.reloadData()
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var models = [Model]()
    
    // UserDefault를 위한 encoder 변수 선언
    let encoder = JSONEncoder()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "firstCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "firstCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension firstCollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 83, height: 120)
    }
}


extension firstCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 내 스토리면 + 버튼 뜨게
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCollectionViewCell", for: indexPath) as! firstCollectionViewCell
            models[indexPath.row].hasActiveStory = false
            cell.configure(with: models[indexPath.row])
            cell.delegate = self
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCollectionViewCell", for: indexPath) as! firstCollectionViewCell
        cell.configure(with: models[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    
}

extension firstCollectionTableViewCell: StoryCellDelegate {
    func didTapButton(at model: Model) {
        // 순서 변경 작업 수행
        var story = model
        
        // 읽은 적이 없으면 가장 뒤로 보냄
        if story.isWatch == false {
            models.remove(at: models.firstIndex(of: story)!)
            story.isWatch = true
            models.append(story)
        }
        
        // 테이블 뷰 또는 컬렉션 뷰를 업데이트하는 작업
        collectionView.reloadData()
        
        // 데이터 encode해서 UserDefault로 저장
        if let encoded = try? encoder.encode(models) {
            UserDefaults.standard.set(encoded, forKey: "storyLists")
        }
        print("didTapButton: \(models)")
    }
    
    
}

