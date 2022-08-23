//
//  BaseViewController.swift
//  SeSACDiary
//
//  Created by 박관규 on 2022/08/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    func configure() {}
    
    func showAlertMessage(title: String, button: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}

