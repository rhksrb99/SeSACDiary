//
//  WriteViewController.swift
//  SeSACDiary
//
//  Created by 박관규 on 2022/08/24.
//

import UIKit
import RealmSwift // 순서 1. Realm import

protocol SelectImageDelegate {
    func sendImageData(image:UIImage)
}

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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func saveButtonClicked() {
        guard let title = mainView.titleTextField.text else {
            showAlertMessage(title: "제목을 입력하세요", button: "확인")
            return
        }
        let task = UserDiary(diaryTitle: title, diaryContents: mainView.contentTextView.text!, diaryDate: Date(), regDate: Date(), photo: nil)
        
        do{
            try localRealm.write {
                localRealm.add(task)
            }
        } catch let error {
            print(error)
        }
        
        if let image = mainView.userImageView.image {
            saveImageToDocument(fileName: "\(task.objectID).jpg", image: image)
        }
        
        dismiss(animated: true)
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
        vc.delegate = self
        transition(vc, transitionStyle: .presentNavigation)
    }
}

extension WriteViewController: SelectImageDelegate {
    func sendImageData(image: UIImage) {
        mainView.userImageView.image = image
        print(#function,"sendImageData")
    }
}
