//
//  ImageSearchViewController.swift
//  SeSACDiary
//
//  Created by 박관규 on 2022/08/24.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON

class SearchImageViewController: BaseViewController {

    // 순서 1번
    var selectImage: UIImage?
    var selectIndexpath: IndexPath?
    var delegate: SelectImageDelegate?
    let mainView = ImageSearchView()
    var photos: [String] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUnsplashImage(item: "cat")
    }

    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(ImageSearchCollectionViewCell.self, forCellWithReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectButtonClicked))
    }

    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func selectButtonClicked() {
        guard let selectImage = selectImage else {
            showAlertMessage(title: "사진을 선택해주세요", button: "확인")
            return
        }
        
        delegate?.sendImageData(image: selectImage)
        dismiss(animated: true)
    }
    
    func loadUnsplashImage(item:String) {
        let url = "https://api.unsplash.com/photos/?page=1&query=\(item)&client_id=0GNfgbkyWnKwlF39xNm2jzH6p1R0XCO6pQVpK0Eolnc"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                let jsonArray = json["results"].arrayValue
                for json in jsonArray {
                    let thumbURL = json["urls"]["thumb"].stringValue
                    self.photos.append(thumbURL)
                }
//                self.searchImageList.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
 
extension SearchImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageSearchCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.layer.borderWidth = selectIndexpath == indexPath ? 4 : 0
        cell.layer.borderColor = selectIndexpath == indexPath ? Constants.BaseColor.point.cgColor : nil
//        cell.setImage(data: UIImage(systemName: "star.fill"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageSearchCollectionViewCell else { return }
        
        selectImage = cell.searchImageView.image
        selectIndexpath = indexPath
        collectionView.reloadData()
        
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function)
        selectImage = nil
        selectIndexpath = nil
        collectionView.reloadData()
    }
    
}
