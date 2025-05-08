//
//  VinoView.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import SwiftUI

struct VinoView: View {
    let cliente: Cliente
    let vinos: [Vino] = [
        Vino(nombre: "Cabernet Sauvignon", precioOriginal: 300.0, descuento: 5),
        Vino(nombre: "Malbec Premium", precioOriginal: 450.0, descuento: 10),
        Vino(nombre: "Syrah Reserva", precioOriginal: 280.0, descuento: 7)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("¡Bienvenido, \(cliente.nombre)!")
                .font(.largeTitle)
                .bold()
            
            Text("Aquí tienes algunas recomendaciones con descuentos especiales:")
                .padding(.bottom)

            List(vinos) { vino in
                VStack(alignment: .leading) {
                    Text(vino.nombre)
                        .font(.headline)
                    Text(String(format: "Precio Original: $%.2f", vino.precioOriginal))
                    Text(String(format: "Descuento: %.0f%%", vino.descuento))
                        .foregroundColor(.green)
                    Text(String(format: "Precio Final: $%.2f", vino.precioConDescuento))
                        .bold()
                        .foregroundColor(.purple)
                }
                .padding(.vertical, 5)
            }
        }
        .padding()
    }
}
