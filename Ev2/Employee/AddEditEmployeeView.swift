//
//  AddEditEmployeeView.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import SwiftUI

struct AddEditEmployeeView: View {
    @Binding var employees: [Employee]
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var birthday: Date = Date()
    @State private var employeeType: String = ""
    var existingEmployee: Employee?

    let employeeTypes = ["Full-time", "Part-time", "Contractor"] // Example types

    init(employees: Binding<[Employee]>, existingEmployee: Employee? = nil) {
        _employees = employees
        self.existingEmployee = existingEmployee
        if let existingEmployee = existingEmployee {
            _name = State(initialValue: existingEmployee.name)
            _birthday = State(initialValue: existingEmployee.birthday)
            _employeeType = State(initialValue: existingEmployee.employeeType)
        }
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                Picker("Employee Type", selection: $employeeType) {
                    ForEach(employeeTypes, id: \.self) { type in
                        Text(type)
                    }
                }
            }
            .navigationTitle(existingEmployee == nil ? "Add New Employee" : "Edit Employee")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    let newEmployee = Employee(name: name, birthday: birthday, employeeType: employeeType)
                    if let existingEmployee = existingEmployee {
                        if let index = employees.firstIndex(of: existingEmployee) {
                            employees[index] = Employee(name: name, birthday: birthday, employeeType: employeeType)
                        }
                    } else {
                        employees.append(newEmployee)
                    }
                    dismiss()
                }
                .disabled(name.isEmpty || employeeType.isEmpty)
            )
        }
    }
}
