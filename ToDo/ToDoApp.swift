//
//  ToDoApp.swift
//  ToDo
//
//  Created by kehinde on 25/08/2023.
//

import SwiftUI

@main
struct ToDoApp: App {
    @StateObject var todoData = ApplicationData()
    
    var body: some Scene {
        WindowGroup {
            ContentView(todoData: todoData)
        }
    }
}
