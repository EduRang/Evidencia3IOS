//
//  Employee.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import Foundation

struct Employee: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var birthday: Date
    var employeeType: String

    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.id == rhs.id
    }
}
