//
//  ApplicationData.swift
//  ToDo
//
//  Created by kehinde on 25/08/2023.
//

import SwiftUI

struct Todo : Hashable, Codable {
    var title:String
    var isDone:Bool
    
}

struct TodoViewModel: Identifiable , Hashable  , Codable{
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
        
        let userDefaults = UserDefaults.standard
        // 1
        if let savedData = userDefaults.object(forKey: "contacts") as? Data {
            
            do{
                // 2
                let savedContacts = try JSONDecoder().decode([TodoViewModel].self, from: savedData)
              todoData = savedContacts
                print(savedContacts)
            } catch {
                todoData = []
                // Failed to convert Data to Contact
            }
        }else{
        todoData = [
                TodoViewModel(item: Todo(title: "first todo", isDone: false)),
                TodoViewModel(item: Todo(title: "second todo", isDone: false)),
            ]
            
        }
    }
}
