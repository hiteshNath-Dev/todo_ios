//
//  ContentView.swift
//  todoApp
//
//  Created by Administrator on 14/12/24.
//

import SwiftUI

struct TodoItem: Identifiable{
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct ContentView: View {
    @State private var todos: [TodoItem] = []
    @State private var newTask: String = ""
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    TextField("Enter new task", text: $newTask).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading, 16)
                    
                    Button(action: addTask, label: {Image(systemName: "plus.circle.fill").font(.title).foregroundColor(.blue)}).padding(.trailing, 16)
                }.padding(.top, 16)
                
                List{
                    ForEach(todos){ todo in
                        HStack {
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle").foregroundColor(todo.isCompleted ? .green : .gray)
                                .onTapGesture{
                                    toggleCompletion(for: todo)
                                }
                            Text(todo.title).strikethrough(todo.isCompleted)
                            
                            Spacer()
                        }
                    }.onDelete(perform: deleteTask)
                }.listStyle(PlainListStyle())
                
            }.navigationTitle("To-Do List")
                .toolbar{
                    EditButton()
                }
        }
        
    }
    
    func addTask(){
        guard !newTask.isEmpty else {return}
        todos.append(TodoItem(title: newTask))
        newTask=""
    }
    
    func toggleCompletion(for todo: TodoItem){
        if let index = todos.firstIndex(where: {$0.id == todo.id}){
            todos[index].isCompleted.toggle()
        }
    }
    
    func deleteTask(at offsets: IndexSet){
        todos.remove(atOffsets: offsets)
    }
}




#Preview {
    ContentView()
}
