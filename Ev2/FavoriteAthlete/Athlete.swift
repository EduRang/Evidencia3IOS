//
//  Athlete.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import Foundation

struct Athlete: Codable, Hashable {
    var name: String
    var age: Int
    var league: String
    var team: String
    
    var description: String {
        return "\(name), \(age) años. Juega en \(team) de la \(league)."
    }
}
