//
//  BaseCollectionViewCell.swift
//  SeSACDiary
//
//  Created by 박관규 on 2022/08/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {}
    
    func setConstraints() {}
}
