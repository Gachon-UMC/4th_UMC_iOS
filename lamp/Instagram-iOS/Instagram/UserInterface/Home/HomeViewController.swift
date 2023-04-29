//
//  HomeViewController.swift
//  Instagram
//
//  Created by 박민서 on 2023/04/29.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var nav_bar: UINavigationBar!
    @IBOutlet weak var table_superView: UIView!
    @IBOutlet weak var UserStoryTableView: UITableView!
    
    var story_list: [story] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table_superView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        UserStoryTableView.center = table_superView.center
        
        story_list.append(story("Lamp","person.crop.circle.fill"))
        story_list.append(story("Name1","Image1"))
        story_list.append(story("Name2","Image2"))
        story_list.append(story("Name3","Image3"))
        
        nav_bar.setBackgroundImage(UIImage(), for: .default)
        // Do any additional setup after loading the view.
        
        let StoryTableViewCellNib = UINib(nibName: String(describing: StoryTableViewCell.self), bundle: nil)
        print(StoryTableViewCellNib)
        //Cell에 리소스 등록 - nib파일의 값을 register
        self.UserStoryTableView.register(StoryTableViewCellNib, forCellReuseIdentifier: "myTableViewCell_ID")
        
        //높이 너비 자동계산
        self.UserStoryTableView.rowHeight = UITableView.automaticDimension
        //예상하는 셀 높이 너비를 120으로
        self.UserStoryTableView.estimatedRowHeight = 120
        
        // 아주 중요 결국 delegate패턴이기 때문에 delegate, Datasource를 나 자신으로 연결해줘야 한다.
        self.UserStoryTableView.delegate = self
        self.UserStoryTableView.dataSource = self
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

extension HomeViewController: UITableViewDelegate {
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row: \(indexPath.row)")
        
        let alertCon = UIAlertController(title: "선택 셀", message: "선택 셀 인덱스는 \(indexPath.row), \(contentArr[indexPath.row])", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertCon.addAction(okAction)
        present(alertCon,animated: true,completion: nil)
    }*/
}

extension HomeViewController: UITableViewDataSource {
    
    //테이블 뷰 셀의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.story_list.count
    }
    
    // 각 cell에 대한 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UserStoryTableView.dequeueReusableCell(withIdentifier: "myTableViewCell_ID", for: indexPath) as! StoryTableViewCell
        
        
        cell.Username.text = story_list[indexPath.row].name
        cell.StroyImage.image = UIImage(named: story_list[indexPath.row].image)

        return cell
    }
}
