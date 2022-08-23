//
//  BaseView.swift
//  SeSACDiary
//
//  Created by 박관규 on 2022/08/24.
//

import UIKit
import SnapKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureUI() {
        self.backgroundColor = Constants.BaseColor.background
    }
    
    func setConstraints() {}
}

