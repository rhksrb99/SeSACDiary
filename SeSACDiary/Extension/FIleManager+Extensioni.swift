//
//  FIleManager+Extensioni.swift
//  SeSACDiary
//
//  Created by 박관규 on 2022/08/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func saveImageToDocument(fileName:String, image:UIImage){
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부경로, 이미지를 저장할 위치
        guard let data = image.jpegData(compressionQuality: 0.5) else {return} // 용량을 줄일 수 있다.
        
        do{
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부경로, 이미지를 저장할 위치
        
        if FileManager.default.fileExists(atPath: fileURL.path){
            return UIImage(contentsOfFile: fileURL.path)
        }else {
            return UIImage(systemName: "heart.fill")
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 세부경로, 이미지를 저장할 위치
        do{
            try FileManager.default.removeItem(at: fileURL)
        }catch let error{
            print(error)
        }
    }
}
