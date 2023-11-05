//
//  ContentView.swift
//  ToDo
//
//  Created by kehinde on 25/08/2023.
//

import SwiftUI

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(20)
            .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(8)
            .shadow(color: .gray, radius: 10)
    }
}

struct BlueButton: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.frame(width: 500)
            .padding()
            .foregroundStyle(.white)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed).font(.custom("Mukta-Medium", size: 22))
    }
}

struct ContentView: View {
    @ObservedObject var todoData : ApplicationData
    @Environment(\.colorScheme) var mode
    @State var input:String = ""
    
    func saveTodo(){
        do {
            // 1
            let encodedData = try JSONEncoder().encode(todoData.todoData)
            
            
            let userDefaults = UserDefaults.standard
            // 2
            userDefaults.set(encodedData, forKey: "contacts")
            
        } catch {
            print("error adding data")
            // Failed to encode Contact to Data
        }
        
    }
    
    func addTodo(){
        todoData.todoData.append(
            TodoViewModel(item: Todo(title: input, isDone: false))
        )
        input = ""
        saveTodo()
        
    }
    
    var body: some View {
        @State var isButtonDisabled = input.count == 0
        
        
        
        ScrollView{
            VStack {
                
                TextField("Enter todo item", text: $input).textFieldStyle(OvalTextFieldStyle()).onSubmit {
                    addTodo()
                }
                ForEach(todoData.todoData.indices , id: \.self){index in
                    HStack{
                        Text(todoData.todoData[index].title).strikethrough(todoData.todoData[index].isDone, color: todoData.todoData[index].isDone ? .red : .black).font(.custom("Mukta-Medium", size: 22)).foregroundColor(mode == .dark ? .white : .black)
                        Spacer()
                        Toggle("",isOn: $todoData.todoData[index].isDone).onChange(of: todoData.todoData[index].isDone) { newValue in
                            
                            
                            do {
                                // 1
                                let encodedData = try JSONEncoder().encode(todoData.todoData)
                                
                                
                                let userDefaults = UserDefaults.standard
                                // 2
                                userDefaults.set(encodedData, forKey: "contacts")
                                
                            } catch {
                                print("error adding data")
                                // Failed to encode Contact to Data
                            }
                            
                            
                            
                        }
                    }
                }
            }
            .padding()
            Spacer()
            
        }.safeAreaInset(edge: .bottom, content: {
            HStack{
                Button(action: {
                    addTodo()
                }){
                    
                    Text("Click Me")
                        .padding()
                        .background(isButtonDisabled ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.disabled(isButtonDisabled).buttonStyle(BlueButton())
            }
            
        }
                        
        )
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(todoData: ApplicationData())
    }
}
