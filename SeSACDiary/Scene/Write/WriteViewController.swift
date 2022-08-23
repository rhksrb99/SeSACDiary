//
//  WriteViewController.swift
//  SeSACDiary
//
//  Created by 박관규 on 2022/08/24.
//

import UIKit
import RealmSwift // 순서 1. Realm import

class WriteViewController: BaseViewController {

    let mainView = WriteView()
    let localRealm = try! Realm() // Realm 테이블에 데이터를 CRUD할 때, Realm 테이블 경로에 접근
    
    override func loadView() {
        self.view = mainView
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    override func configure() {
        mainView.searchImageButton.addTarget(self, action: #selector(selectImageButtonClicked), for: .touchUpInside)
        mainView.sampleButton.addTarget(self, action: #selector(sampleButtonClicked), for: .touchUpInside)
    }
    
    // DB Create Sample
    @objc func sampleButtonClicked() {
        
        let task = UserDiary(diaryTitle: "오늘의 일기\(Int.random(in: 1...1000))", diaryContents: "일기 텍스트", diaryDate: Date(), regDate: Date(), photo: nil) // => Record
        
        try! localRealm.write {
            localRealm.add(task) // create
            print("Realm Succeed")
            dismiss(animated: true)
        }
    }
    
    @objc func selectImageButtonClicked() {
        let vc = SearchImageViewController()
        transition(vc)
    }
}
