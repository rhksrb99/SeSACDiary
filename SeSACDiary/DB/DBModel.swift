//
//  DBModel.swift
//  SeSACDiary
//
//  Created by 박관규 on 2022/08/24.
//

import Foundation
import RealmSwift

// UserDiary : 테이블 이름
// @Persisted: 컬럼
class UserDiary: Object {
    @Persisted var diaryTitle: String // 제목(필수) PK
    @Persisted var diaryContents: String? // 내용(옵션)
    @Persisted var diaryDate = Date() // 작성날짜(필수)
    @Persisted var regDate = Date() // 등록날짜(필수)
    @Persisted var favorite: Bool // 즐겨찾기(필수)
    @Persisted var photo: String? // 사진 String (옵션)
    
    // PK(필수) : Int, UUID, ObjectID
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(diaryTitle:String, diaryContents:String?, diaryDate:Date, regDate:Date, photo:String?) {
        self.init()
        self.diaryTitle = diaryTitle
        self.diaryContents = diaryContents
        self.diaryDate = diaryDate
        self.regDate = regDate
        self.favorite = false
        self.photo = photo
    }
}
