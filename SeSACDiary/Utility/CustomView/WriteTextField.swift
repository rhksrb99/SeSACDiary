//
//  WriteTextField.swift
//  SeSACDiary
//
//  Created by 박관규 on 2022/08/24.
//

import UIKit

class WriteTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        backgroundColor = Constants.BaseColor.background
        textAlignment = .center
        borderStyle = .none
        layer.cornerRadius = Constants.Desgin.cornerRadius
        layer.borderWidth = Constants.Desgin.borderWidth
        layer.borderColor = Constants.BaseColor.border
    }

}
