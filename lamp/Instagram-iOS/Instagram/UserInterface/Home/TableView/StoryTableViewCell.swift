//
//  StoryTableViewCell.swift
//  Instagram
//
//  Created by 박민서 on 2023/05/07.
//

import UIKit

///StoryCollectionView가 들어가는 StoryTableViewCell
class StoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CollectionView: UICollectionView!    //StoryCollectionView
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerXib()   //StoryCollectionView의 Cell들을 register
        registerDelegateNdataSource()  //StoryCollectionView의 delegate,dataSource를 등록
        self.layer.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0, set: "Normal") //StoryTableViewCell에 하단 테두리 추가 -> StoryCell이 포함된 container에 테두리 효과
    }
    
    private func registerXib(){
        
        let firststoryNib = UINib(nibName: "FirstCollectionViewCell", bundle: nil)  //본인 프로필 cell
        CollectionView.register(firststoryNib, forCellWithReuseIdentifier: "FirstCollectionViewCell")
        let storyNib = UINib(nibName: "StoryCollectionViewCell", bundle: nil)   //다른 유저 cell
        CollectionView.register(storyNib, forCellWithReuseIdentifier: "StoryCollectionViewCell")
        
    }
    
    private func registerDelegateNdataSource() {
        CollectionView.delegate = self
        CollectionView.dataSource = self
    }
    
}


extension StoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    
    ///StoryCell을 선택했을때 - Cell의 이미지를 선택한 것과 다른 작동
    ///imagetapgesture의 작동과 didselectItemAt이 서로 참조하는 부분이 있어 추후 수정이 필요함
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? StoryCollectionViewCell {   //해당 아이템 cell로 선언
            cell.imageViewTapped(isImageTap: false) //Storycell의 imageViewTapped 메소드에 CollectionVeiwcell로 tap했다는 값을 같이 보내 호출 - 이미지를 탭한 게 아님
        }
        
        //이미지 혹은 셀을 탭하여 스토리가 push되기 전, UserDefaults에서 StoryList를 불러와 데이터를 처리
        if let storedData = UserDefaults.standard.data(forKey: "Story_List"), var StoryList = try? JSONDecoder().decode([story].self, from: storedData) {
            //print("불러오기 성공")
            if StoryList[indexPath.item].isViewed == false {    //해당 스토리를 보지 않았다면 본 값으로 처리, storylist에서 맨 뒤로 보냄
                StoryList[indexPath.item].isViewed = true
                StoryList.append(StoryList.remove(at: indexPath.item))
                
                if let updateStoryList = try? JSONEncoder().encode(StoryList) {     // 변경된 사항을 다시 encoding하여 UserDefaults의 storylist에 저장
                    UserDefaults.standard.set(updateStoryList, forKey: "Story_List")
                    UserDefaults.standard.synchronize() //UI 변경이 포함되므로 synchronize 필요
                    //print("세팅도 성공")
                }
            }
        }
        
        // NotificationCenter에 옵저버 추가
        //해당 observer는 하트를 눌렀는지에 대한 observer임.
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: NSNotification.Name("NotificationIdentifier"), object: nil)
        collectionView.reloadData() //모든 변경사항 마친 후 User들의 StoryCell들을 리로드하기
    }
    
    // 알림 수신 처리 메서드
    // 하트의 탭 처리를 userDefaults에서 불러와서 저장함.
    @objc func notificationReceived(_ notification: NSNotification) {
        // 알림 처리 코드 작성
        if let userInfo = notification.userInfo {
            // 알림과 함께 전달된 정보 사용
            let gotHeart = userInfo["gotHeart"] as? Bool
            let storyname = userInfo["storyname"] as? String
            // 사용자 정의 데이터 처리
            
            if let storedData = UserDefaults.standard.data(forKey: "Story_List"), var StoryList = try? JSONDecoder().decode([story].self, from: storedData) {
                //print("noti불러오기 성공")
                for i in 1..<StoryList.count {
                    if StoryList[i].StoryImage == storyname {
                        StoryList[i].gotHeart = gotHeart!
                        break
                    }
                }
                
                    if let updateStoryList = try? JSONEncoder().encode(StoryList) {
                        UserDefaults.standard.set(updateStoryList, forKey: "Story_List")
                        UserDefaults.standard.synchronize()
                        //print("noti세팅도 성공")
                    }
                if let collectionView = self.CollectionView {
                        collectionView.reloadData()
                    //print("objc 함수에서 리로딩 성공")
                    }
                
            }
        }
        
        // 옵저버 제거
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("NotificationIdentifier"), object: nil)
        
    }

        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return story_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.item == 0 {
                    // 본인 프로필 셀에 대한 처리를 수행
                    let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
                    firstCell.UserImage.image = UIImage(named: story_list[indexPath.row].image) ?? UIImage()
                    firstCell.UserImage.contentMode = .scaleAspectFill
                    firstCell.UserName.text = story_list[indexPath.row].name
                    return firstCell
                }
        else {  //나머지 유저들의 프로필 셀에 대한 처리를 수행
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as! StoryCollectionViewCell
            
            //userDefautls에서 데이터 불러와서 StoryCollectionViewCell들에 데이터 저장
            if let storedData = UserDefaults.standard.data(forKey: "Story_List"), let StoryList = try? JSONDecoder().decode([story].self, from: storedData) {
                if StoryList[indexPath.item].isViewed {
                    cell.Color_view.backgroundColor = UIColor.gray
                }
                cell.StoryHeart = StoryList[indexPath.item].gotHeart
                cell.UserImage.image = UIImage(named: StoryList[indexPath.row].image) ?? UIImage()
                //print(cell.UserImage.image)
                cell.UserName.text = StoryList[indexPath.row].name
                //print(cell.UserName.text)
                cell.StoryImage = StoryList[indexPath.row].StoryImage
                cell.StoryTime = StoryList[indexPath.row].time

                cell.imageViewTappedClosure = { self.collectionView(collectionView, didSelectItemAt: indexPath) } //cell의 imageViewTappedClosuer함수를 구현, 본 View의 self.collectionView(_,didSelectItemAt:) 호출
            }
            return cell
        }
    }
}
