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
    @IBOutlet weak var PostCollectionView: UICollectionView!
    
    @IBOutlet weak var StoryTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    let Device_width = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nav_bar.setBackgroundImage(UIImage(), for: .default)
        nav_bar.shadowImage = UIImage()
        addDummyStories()
        addDummyPosts()
        
        self.StoryTableView.delegate = self
        self.StoryTableView.dataSource = self
        
        StoryTableView.contentInsetAdjustmentBehavior = .always
        
        let storyCell = UINib(nibName: "StoryTableViewCell", bundle: nil)
            StoryTableView.register(storyCell, forCellReuseIdentifier: "StoryTableViewCell")
        let postCell = UINib(nibName: "PostTableViewCell", bundle: nil)
            StoryTableView.register(postCell, forCellReuseIdentifier: "PostTableViewCell")
        
        
        StoryTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        /*
        
        self.StoryCollectionView.delegate = self
        self.StoryCollectionView.dataSource = self
        self.StoryCollectionView.layer.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0)
        
        self.PostCollectionView.delegate = self
        self.PostCollectionView.dataSource = self
        
        let FirstStoryNib = UINib(nibName: "FirstCollectionViewCell", bundle: nil)
        StoryCollectionView.register(FirstStoryNib, forCellWithReuseIdentifier: "FirstCollectionViewCell")
        
        let SeconStoryNib = UINib(nibName: "StoryCollectionViewCell", bundle: nil)
        StoryCollectionView.register(SeconStoryNib, forCellWithReuseIdentifier: "StoryCollectionViewCell")
        
        let PostNib = UINib(nibName: "PostCollectionViewCell", bundle: nil)
        PostCollectionView.register(PostNib, forCellWithReuseIdentifier: "PostCollectionViewCell")
        */
        
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        let item = DispatchWorkItem {
            sender.endRefreshing()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: item)
        }

}


/*
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        // CollectionView item 개수
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == StoryCollectionView {
                return story_list.count
            } else /*if collectionView == PostCollectionView*/ {
                return post_list.count
            }
        }
        
        // CollectionView Cell의 Object
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if collectionView == StoryCollectionView {
                if indexPath.item == 0 {
                            // 첫 번째 셀에 대한 특별한 처리를 수행합니다.
                            let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
                            firstCell.UserImage.image = UIImage(named: story_list[indexPath.row].image) ?? UIImage()
                            firstCell.UserName.text = story_list[indexPath.row].name
                            return firstCell
                        }
                else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as! StoryCollectionViewCell
                    cell.UserImage.image = UIImage(named: story_list[indexPath.row].image) ?? UIImage()
                    cell.UserName.text = story_list[indexPath.row].name
                    return cell
                }
            } else /*if collectionView == PostCollectionView*/ {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
                cell.UserID.text = post_list[indexPath.row].UserID
                cell.UserName.text = post_list[indexPath.row].UserID
                cell.UserImage.image = UIImage(named: post_list[indexPath.row].UserImage) ?? UIImage()
                cell.PostImage.image = UIImage(named: post_list[indexPath.row].PostImage) ?? UIImage()
                cell.PostLike.text = "좋아요 \(post_list[indexPath.row].PostLike)개"
                cell.User_Text.text = post_list[indexPath.row].UserText
                cell.CommentCount.text = "댓글 \(post_list[indexPath.row].CommentCount)개 모두 보기"
                cell.PostDate.text = post_list[indexPath.row].PostDate
                return cell
            }
        }
        
        
        // CollectionView Cell의 Size
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if collectionView == StoryCollectionView {
                let width: CGFloat = collectionView.frame.width/4 - 5
                let height: CGFloat = collectionView.frame.height
                return CGSize(width: width, height: height)
            } else /*if collectionView == PostCollectionView*/ {
                let width: CGFloat = collectionView.frame.width
                let height: CGFloat = collectionView.frame.height
                return CGSize(width: width, height: height)
            }
            
        }
        
        // CollectionView Cell의 위아래 간격
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            if collectionView == StoryCollectionView {
                return 1.0
            } else /*if collectionView == PostCollectionView*/ {
                return 0.0
            }
        }
        
        // CollectionView Cell의 옆 간격
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            if collectionView == StoryCollectionView {
                return 1.0
            } else /*if collectionView == PostCollectionView*/ {
                return 0.0
            }
        }
}
*/

extension HomeViewController: UITableViewDelegate{
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 120 : 570
    }
    
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return post_list.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as? StoryTableViewCell else { return UITableViewCell() }
            /*
            // contentView의 왼쪽과 오른쪽을 TableView의 왼쪽과 오른쪽에 맞춤
               cell.contentView.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   cell.contentView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
                   cell.contentView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
               ])
               
               // subviews의 너비를 contentView와 같게 설정
               for subview in cell.contentView.subviews {
                   subview.translatesAutoresizingMaskIntoConstraints = false
                   NSLayoutConstraint.activate([
                       subview.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                       subview.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
                   ])
               }*/
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
            /*
            // contentView의 왼쪽과 오른쪽을 TableView의 왼쪽과 오른쪽에 맞춤
               cell.contentView.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   cell.contentView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
                   cell.contentView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
               ])
               
               // subviews의 너비를 contentView와 같게 설정
               for subview in cell.contentView.subviews {
                   subview.translatesAutoresizingMaskIntoConstraints = false
                   NSLayoutConstraint.activate([
                       subview.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                       subview.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
                   ])
               }*/
            cell.UserID.text = post_list[indexPath.row].UserID
            cell.UserName.text = post_list[indexPath.row].UserID
            cell.UserImage.image = UIImage(named: post_list[indexPath.row].UserImage) ?? UIImage()
            cell.PostImage.image = UIImage(named: post_list[indexPath.row].PostImage) ?? UIImage()
            cell.PostLike.text = "좋아요 \(post_list[indexPath.row].PostLike)개"
            cell.User_Text.text = post_list[indexPath.row].UserText
            cell.CommentCount.text = "댓글 \(post_list[indexPath.row].CommentCount)개 모두 보기"
            cell.PostDate.text = post_list[indexPath.row].PostDate
            return cell
        default:
            print("?")
            return UITableViewCell()
        }
    }
    
}
