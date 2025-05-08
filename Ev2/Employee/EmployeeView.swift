//
//  EmployeeView.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import SwiftUI

struct EmployeeView: View {
    @State private var employees: [Employee] = []
    @State private var isAddingNewEmployee = false
    @State private var employeeToEdit: Employee?
    @State private var showingDeleteAlert = false
    @State private var employeeToDelete: Employee?

    var body: some View {
        NavigationView {
            List {
                ForEach($employees) { $employee in
                    HStack {
                        Button {
                            employeeToEdit = employee
                        } label: {
                            Text(employee.name)
                        }
                        Spacer()
                        Button {
                            employeeToDelete = employee
                            showingDeleteAlert = true
                        } label: {
                            Image(systemName: "trash")
                        }
                        .buttonStyle(.plain)
                    }
                    .listRowSeparator(.hidden)
                }
                .alert(isPresented: $showingDeleteAlert) {
                    Alert(
                        title: Text("¿Eliminar empleado?"),
                        message: employeeToDelete.map { Text("¿Seguro que quieres eliminar a \($0.name)?") },
                        primaryButton: .destructive(Text("Eliminar")) {
                            if let employeeToDelete = employeeToDelete,
                               let index = employees.firstIndex(where: { $0.id == employeeToDelete.id }) {
                                employees.remove(at: index)
                            }
                            employeeToDelete = nil // Reset
                        },
                        secondaryButton: .cancel() {
                            employeeToDelete = nil // Reset
                        }
                    )
                }
            }
            .navigationTitle("Employee Roster")
            .toolbar {
                Button {
                    isAddingNewEmployee = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isAddingNewEmployee) {
                AddEditEmployeeView(employees: $employees)
            }
            .sheet(item: $employeeToEdit) { employee in
                AddEditEmployeeView(employees: $employees, existingEmployee: employee)
            }
        }
    }
}
