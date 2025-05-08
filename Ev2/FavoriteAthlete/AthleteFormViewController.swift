//
//  AthleteFormViewController.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import SwiftUI

struct AthleteFormView: View {
    @State var jugador: Athlete
    let onSave: (Athlete) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    let ligas = [
        "La Liga",
        "Premier League",
        "Serie A",
        "Bundesliga",
        "Ligue 1",
        "MLS",
        "Saudi Pro League"
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Información Personal")) {
                    TextField("Nombre completo", text: $jugador.name)
                    Stepper(value: $jugador.age, in: 16...45) {
                        Text("Edad: \(jugador.age)")
                    }
                }
                
                Section(header: Text("Información del Equipo")) {
                    Picker("Liga", selection: $jugador.league) {
                        ForEach(ligas, id: \.self) { liga in
                            Text(liga).tag(liga)
                        }
                    }
                    
                    TextField("Equipo", text: $jugador.team)
                }
                
                Section {
                    Text(jugador.description)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle(jugador.name.isEmpty ? "Agregar Jugador" : "Editar Jugador")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        onSave(jugador)
                        dismiss()
                    }
                    .disabled(jugador.name.isEmpty || jugador.league.isEmpty || jugador.team.isEmpty)
                }
            }
        }
    }
}
