//
//  ListaTareasView.swift
//  Ev2
//
//  Created by ALUMNO on 01/04/25.
//

import SwiftUI

struct ListaTareasView: View {
    @State var tasks: [Task] = [
        Task(name: "Casa: Lavar trastes"),
        Task(name: "Casa: Barrer"),
        Task(name: "Escuela: Hacer tarea"),
        Task(name: "Escuela: Estudiar")
    ]

    var body: some View {
        NavigationView {
            VStack {
                ForEach(categories, id: \.self) { category in
                    TextBox(taskType: category, tasks: $tasks)
                        .padding(.vertical, 4)
                }
                
                List {
                    ForEach($tasks) { $task in
                        HStack {
                            Button(action: {
                                task.isCompleted.toggle()
                            }) {
                                HStack {
                                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(task.isCompleted ? .blue : .gray)
                                    
                                    Text(task.name)
                                        .foregroundColor(task.isCompleted ? .blue : .primary)
                                        .strikethrough(task.isCompleted, color: .blue)
                                    Spacer()
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Button(action: {
                                deleteTask(task)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }
            .navigationTitle("Lista de Tareas")
                        #if os(iOS)
                        .navigationBarTitleDisplayMode(.inline)
                        #endif
        }
    }

    func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
    }
}

var categories = [
    "Casa", "Escuela"
]

struct TextBox: View {
    @State var taskDescription: String = ""
    var taskType: String
    @Binding var tasks: [Task]
    
    var body: some View {
        VStack {
            TextEditor(text: $taskDescription)
                .foregroundColor(.gray)
                .frame(height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.blue, lineWidth: 1)
                )
                .padding(.horizontal, 12)
            Button("Agregar tarea de \(taskType)") {
                addTask()
            }
            .buttonStyle(.bordered)
            .tint(.blue)
        }
    }
    
    func addTask() {
        guard !taskDescription.isEmpty else { return }
        tasks.append(Task(name: "\(taskType): \(taskDescription)"))
        taskDescription = ""
    }
}
