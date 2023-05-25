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
        
        // 스토리 화면에서 하트를 클릭하면 해당 class로 notification 전송
        NotificationCenter.default.addObserver(self, selector: #selector(getHeartStatus(_:)), name: NSNotification.Name("HeartSend"), object: nil)
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
    
    // 스토리 화면에서 하트를 클릭하면 isHeartFilled가 반영된 모델로 배열 업데이트
    @objc func getHeartStatus(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            // MARK: - 고유한 값인 Id를 통해 배열에서 구분하기 위해 model 자체를 가져옴. Bool로 t/f만 받으면 이게 배열에 몇 번째에 있는 모델이 바뀐 것인지 알 수가 없다. (seori)
            // id 비교를 위해서 model을 가져옴? 맞나?
            let modelForStory = userInfo["model"] as! Model
            
            // id를 비교하면서 동일한 id를 찾으면 바꾸고 아니면 넘김
            let changedModels = models.map { model in
                model.id == modelForStory.id ? modelForStory : model
            }
            
            // 업데이트 된 배열을 UserDefaults로 저장
            if let encoded = try? encoder.encode(changedModels) {
                UserDefaults.standard.set(encoded, forKey: "storyLists")
            }
        }
        // observer 삭제
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("HeartSend"), object: nil)
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
        // if let 써서 안전하게 unwrapping
        if let firstIndex = models.firstIndex(of: story) {
            models.remove(at: firstIndex)
            story.isWatch = true
            models.append(story)
        }
        
        // 데이터 encode해서 UserDefault로 저장
        if let encoded = try? encoder.encode(models) {
            UserDefaults.standard.set(encoded, forKey: "storyLists")
        }
        // 테이블 뷰 또는 컬렉션 뷰를 업데이트하는 작업
        collectionView.reloadData()
    }
}

