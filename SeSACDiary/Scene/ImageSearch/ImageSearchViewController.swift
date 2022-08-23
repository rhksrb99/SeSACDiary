//
//  ImageSearchViewController.swift
//  SeSACDiary
//
//  Created by 박관규 on 2022/08/24.
//

import UIKit
import Kingfisher

class SearchImageViewController: BaseViewController {

    let mainView = ImageSearchView()

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(ImageSearchCollectionViewCell.self, forCellWithReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier)
    }
}
 
extension SearchImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageSearchCollectionViewCell else {
            return UICollectionViewCell()
        }

//        cell.setImage(data: ImageDummy.data[indexPath.item].url)

        return cell
    }

}
