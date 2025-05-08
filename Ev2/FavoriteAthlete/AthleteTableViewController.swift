//
//  AthleteTableViewController.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import SwiftUI

struct AthleteTableView: View {
    @State private var jugadores: [Athlete] = []
    @State private var mostrarFormularioNuevo = false
    @State private var jugadorEditandoIndex: Int? = nil
    
    let jugadoresEjemplo = [
        Athlete(name: "Lionel Messi", age: 37, league: "MLS", team: "Inter Miami"),
        Athlete(name: "Karim Benzema", age: 37, league: "Saudi Pro League", team: "Al-Ittihad")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(Array(zip(jugadores.indices, jugadores)), id: \.1) { index, jugador in
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(jugador.name)
                                        .font(.headline)
                                    Text(jugador.description)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    jugadorEditandoIndex = index
                                }) {
                                    Image(systemName: "pencil")
                                }
                            }
                            .padding()
                            
                            Divider()
                        }
                        .contentShape(Rectangle())
                    }
                }
            }
            .navigationTitle("Jugadores Favoritos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        mostrarFormularioNuevo = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $mostrarFormularioNuevo) {
                AthleteFormView(
                    jugador: Athlete(name: "", age: 25, league: "", team: ""),
                    onSave: { nuevoJugador in
                        jugadores.append(nuevoJugador)
                        mostrarFormularioNuevo = false
                    }
                )
            }
            .sheet(isPresented: Binding(
                get: { jugadorEditandoIndex != nil },
                set: { if !$0 { jugadorEditandoIndex = nil } }
            )) {
                if let index = jugadorEditandoIndex {
                    AthleteFormView(
                        jugador: jugadores[index],
                        onSave: { jugadorActualizado in
                            jugadores[index] = jugadorActualizado
                            jugadorEditandoIndex = nil
                        }
                    )
                }
            }
            .onAppear {
                jugadores = jugadoresEjemplo
            }
        }
    }
}

