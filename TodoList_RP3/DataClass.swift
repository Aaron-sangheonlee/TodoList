//
//  File.swift
//  TodoList_RP3
//
//  Created by 이상헌 on 2021/07/18.
//

import Foundation



struct Todolist {
    var title : String = "" //할 일 제목
    var content : String? //할 일 세부 내용
    var isComplete: Bool //할 일 완료 여부
    
    init(title : String, content : String?, isComplete: Bool = false) {
        self.title = title
        self.content = content
        self.isComplete = isComplete
    }
}
