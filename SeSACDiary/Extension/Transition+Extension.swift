//
//  Transition+Extension.swift
//  SeSACDiary
//
//  Created by 박관규 on 2022/08/24.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present
        case presentFullScreen
        case push
    }
    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        case .presentFullScreen:
            let vc = viewController
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
}
