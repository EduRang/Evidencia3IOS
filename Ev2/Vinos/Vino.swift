//
//  Vino.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import Foundation

struct Vino: Identifiable {
    let id = UUID()
    let nombre: String
    let precioOriginal: Double
    let descuento: Double // en porcentaje, por ejemplo: 10 para 10%

    var precioConDescuento: Double {
        return precioOriginal * (1 - descuento / 100)
    }
}
