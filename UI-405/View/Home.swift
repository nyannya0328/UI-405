//
//  Home.swift
//  UI-405
//
//  Created by nyannyan0328 on 2021/12/28.
//

import SwiftUI
import RealmSwift

struct Home: View {
    
    @ObservedResults(TaskItem.self, sortDescriptor: SortDescriptor.init(keyPath: "taskDate", ascending: false)) var taskFetched
    
    
    @State var lastTaskAdded : String = ""
    
    
    var body: some View {
        NavigationView{
            
            ZStack{
                
                if taskFetched.isEmpty{
                    
                    Text("Add to Task")
                        .font(.caption.bold())
                        .foregroundColor(.gray)
                }
                
                else{
                    
                    
                    List{
                        
                        ForEach(taskFetched){task in
                            
                            
                            TaskRowView(taskItemtask: task, lastTaskAdded: $lastTaskAdded)
                            
                        }
                        
                        
                        
                    }
                    .listStyle(.insetGrouped)
                    
                    
                }
            }
            .navigationTitle("REALM")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    
                    Button {
                        
                        
                        let task = TaskItem()
                        
                        lastTaskAdded = task.id.stringValue
                        $taskFetched.append(task)
                        
                    
                        
                        
                    } label: {
                        
                        
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.orange)
                    }

                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                
                lastTaskAdded = ""
                
                guard let last = taskFetched.last else{return}
                
                
                if last.taskTitle == ""{
                    
                    
                    $taskFetched.remove(last)
                    
                }
                
            }
            
            
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct TaskRowView : View{
    
    @ObservedRealmObject var taskItemtask : TaskItem
    
    
    @Binding var lastTaskAdded : String
   
    
    
    
    @FocusState var showKey : Bool
    
    var body: some View{
        
        
        HStack{
            
            
            Menu {
                
                
                Button("Missed"){
                    
                    
                    $taskItemtask.taskStatus.wrappedValue = .missed
                    
                    
                }
                
                Button("Completed"){
                    
                    $taskItemtask.taskStatus.wrappedValue = .completed
                    
                    
                    
                }
                
            } label: {
                
                
                Circle()
                    .stroke(.gray)
                    .frame(width: 20, height: 20)
                    .overlay(
                    
                    Circle()
                        .fill(taskItemtask.taskStatus == .missed ? .red : (taskItemtask.taskStatus == .pending ? .yellow : .green))
                    
                    
                    )
                
                
                
                
            }
            
            
            
            VStack(alignment: .leading, spacing: 10) {
                
                
                TextField("Kavsoft", text: $taskItemtask.taskTitle)
                    .focused($showKey)
                
                
                if taskItemtask.taskTitle != ""{
                    
                    
                    Picker(selection: .constant("")) {
                        
                        
                        DatePicker(selection: $taskItemtask.taskDate, displayedComponents: .date){
                            
                            
                            
                        }
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        
                        
                        
                        
                    } label: {
                        
                        
                        HStack{
                            
                            
                            Image(systemName: "calendar.circle.fill")
                            
                            Text(taskItemtask.taskDate.formatted(date: .numeric, time: .omitted))
                            
                            
                            
                            
                        }
                        
                        
                        
                    }

                    
                    
                }
                
                
                
                
                
                
            }
            

            
            
            
        }
        .onAppear {
            if lastTaskAdded == taskItemtask.id.stringValue{
                
                
                showKey.toggle()
            }
            
            
        }
    }
    
    
}



