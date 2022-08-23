//
//  HomeViewController.swift
//  SeSACDiary
//
//  Created by 박관규 on 2022/08/24.
//

import UIKit
import SnapKit
import RealmSwift // 순서 1. import
import SwiftUI

class HomeViewController: UIViewController {
    
    // 순서 2. 경로설정
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!{
        didSet{
            // 화면 갱신은 화면 전환 코드 및 생명주기 실행 점검 필요!
            tableView.reloadData()
            print("갱신완료")
        }
    }
    
    // 지연저장 프로퍼티
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 100
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .lightGray
        return view
    }() // 즉시 실행 클로저
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        print(tasks[1])
//        print(tasks[1].diaryTitle)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton]
    }
    
    // present, overCurrentContext, overFullSreen의 스타일로 지정하면 viewWillAppear이 실행되지 않는다.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(#function)
        fetchRealm()
        
        
    }
    
    func fetchRealm() {
        // 순서 3. Realm 데이터를 정렬해 tasks에 담기
                                // 저장하려고 하는 테이블의 이름                              // 최신순: false
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryTitle", ascending: true)
    }
    
    @objc func sortButtonClicked() {
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "regDate", ascending: true)
        
//        tableView.reloadData() // 정렬, 필터, 즐겨찾기 등 데이터가 변하게 되면 매번 작성해야한다.
        // tasks를 선언할 떄 didset을 이용하여 값이 변경되면 tableView.reloadData가 실행되도록 하면 반복적이 코드가 줄어든다.
    }
    
    @objc func filterButtonClicked() {
        
                                                                        // 스트링을 이용하여 비교할 떈 ''을 사용하여
                                                                        // 넣어줘야한다.
        tasks = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS '일기'")
                                                //.filter("diaryTitle CONTAINS[c] 'a'") 대소문자를 모두 포함하여 찾기
                                                //.filter("diaryTitle = '오늘의 일기1000'")
        
    }
    
    @objc func plusButtonClicked() {
        let vc = WriteViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tasks[indexPath.row].diaryTitle
        return cell
    }
    
    
    // 참고. TableView Editing Mode
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            
            
            try! self.localRealm.write {
                // 하나의 레코드에서 특정 컬럼 하나만 변경
                self.tasks[indexPath.row].favorite = !self.tasks[indexPath.row].favorite
                
                // 하나의 테이블에 특정 컬럼 전체 값을 변경
//                self.tasks.setValue(true, forKey: "favorite")
                
                // 하나의 레코드에서 여러 컬럼들이 변경
                //self.localRealm.create(UserDiary.self, value: ["objectId":self.tasks[indexPath.row].objectID, "diaryContent":"변경 테스트", "diaryTitle":"제목"], update: .modified)
                
                print("Realm Update Succeed, reloadRows가 필요하다.")
            }
            // 1. 스와이프한 셀 하나만 ReloadRows 코드를 구현 => 상대적으로 효율적이다.
            // 2. 데이터가 변경됐으니 다시 realm에서 데이터를 가져오기 => didSet 일관적 형태로 갱신된다.
            self.fetchRealm()
        }
        
        // realm 데이터 기준으로 이미지를 변경한다.
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        
        favorite.image = UIImage(systemName: "star.fill")
        favorite.backgroundColor = .lightGray
        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            print("favorite Button Clicked")
        }
        
        let example = UIContextualAction(style: .normal, title: "예시") { action, view, completionHandler in
            print("example Button Clicked")
        }
        
        return UISwipeActionsConfiguration(actions: [favorite, example])
        
    }
    
}
