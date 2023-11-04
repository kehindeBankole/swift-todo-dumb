//
//  ApplicationData.swift
//  ToDo
//
//  Created by kehinde on 25/08/2023.
//

import SwiftUI

struct Todo : Hashable {
    var title:String
    var isDone:Bool
    
}

struct TodoViewModel: Identifiable , Hashable {
    var item : Todo
    var id = UUID()
    var title : String {
        return item.title
    }
    var isDone : Bool {
        get{
            return item.isDone
        }
        set(newValue){
            return item.isDone = newValue
        }
    }
}

class ApplicationData: ObservableObject {
    @Published var todoData:[TodoViewModel]
    
    init(){
        todoData = [
            TodoViewModel(item: Todo(title: "first todo", isDone: false)),
        TodoViewModel(item: Todo(title: "second todo", isDone: false)),
        ]
    }
}
