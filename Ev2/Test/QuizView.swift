//
//  QuizView.swift
//  Ev2
//
//  Created by ALUMNO on 01/04/25.
//

import SwiftUI

struct QuizView: View {
    enum Question {
        case footPreference
        case favoriteWorldCup
        case fifaPreference
        case result
    }
    
    @State private var currentQuestion: Question = .footPreference
    @State private var footPreferences = [
        "Pierna derecha": false,
        "Pierna izquierda": false,
        "Cabeza": false,
        "Manos": false
    ]
    @State private var selectedPlayer: String? = nil
    @State private var fifaPreference: Double = 6
    
    @State private var scores: [String: Int] = ["Iniesta": 0, "Messi": 0, "CR7": 0, "Neuer": 0]
    
    var body: some View {
        VStack {
            switch currentQuestion {
            case .footPreference:
                footPreferenceQuestion
            case .favoriteWorldCup:
                favoriteWorldCupQuestion
            case .fifaPreference:
                fifaPreferenceQuestion
            case .result:
                ResultadoView(result: calculateResult())
            }
        }
    }
    
    // Pregunta 1 - Múltiples Toggles
    var footPreferenceQuestion: some View {
        VStack {
            Text("¿Qué partes del cuerpo prefieres usar?")
                .font(.title2)
                .padding()
            
            ForEach(Array(footPreferences.keys.sorted()), id: \.self) { key in
                Toggle(key, isOn: Binding(
                    get: { footPreferences[key] ?? false },
                    set: { newValue in
                        footPreferences[key] = newValue
                        // Verificar si al menos una está seleccionada
                        if newValue && !hasAtLeastOnePreferenceSelected() {
                            // Avanzar después de un pequeño delay para mejor UX
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                withAnimation {
                                    currentQuestion = .favoriteWorldCup
                                }
                            }
                        }
                    }
                ))
                .padding(.horizontal)
            }
            
            Button("Siguiente") {
                withAnimation {
                    currentQuestion = .favoriteWorldCup
                }
            }
            .padding()
            .disabled(!hasAtLeastOnePreferenceSelected())
        }
    }
    
    // Pregunta 2 - Botones con navegación automática
    var favoriteWorldCupQuestion: some View {
        VStack {
            Text("¿Cuál fue tu mundial favorito?")
                .font(.title2)
                .padding()
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                let options = ["Brasil 2014", "Sudáfrica 2010", "Qatar 2022", "Alemania 2006"]
                let players = ["Neuer", "Iniesta", "Messi", "CR7"]
                
                ForEach(0..<options.count, id: \.self) { index in
                    Button(action: {
                        selectedPlayer = players[index]
                        scores[players[index], default: 0] += 1
                        
                        // Navegación automática después de seleccionar
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation {
                                currentQuestion = .fifaPreference
                            }
                        }
                    }) {
                        Text(options[index])
                            .padding()
                            .frame(width: 150, height: 80)
                            .background(getButtonColor(index: index))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedPlayer == players[index] ? Color.white : Color.clear, lineWidth: 3)
                            )
                    }
                }
            }
            .padding()
        }
    }
    
    // Pregunta 3 - Slider
    var fifaPreferenceQuestion: some View {
        VStack {
            Text("¿Qué tanto te gusta jugar FIFA?")
                .font(.title2)
                .padding()
            
            Slider(value: $fifaPreference, in: 0...12, step: 1)
                .padding()
                .onChange(of: fifaPreference) { newValue in
                    // Navegación automática después de mover el slider
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        updateScoresBasedOnFifaPreference()
                        withAnimation {
                            currentQuestion = .result
                        }
                    }
                }
            
            Text("Valor: \(Int(fifaPreference))")
                .font(.headline)
            
            Button("Ver Resultado") {
                updateScoresBasedOnFifaPreference()
                withAnimation {
                    currentQuestion = .result
                }
            }
            .padding()
        }
    }
    
    // Funciones de ayuda
    private func hasAtLeastOnePreferenceSelected() -> Bool {
        footPreferences.values.contains(true)
    }
    
    private func updateScoresBasedOnFifaPreference() {
        if fifaPreference <= 3 {
            scores["Iniesta", default: 0] += 1
        } else if fifaPreference <= 6 {
            scores["Neuer", default: 0] += 1
        } else if fifaPreference <= 9 {
            scores["Messi", default: 0] += 1
        } else {
            scores["CR7", default: 0] += 1
        }
    }
    
    func calculateResult() -> String {
        let sortedScores = scores.sorted { $0.value == $1.value ? $0.key < $1.key : $0.value > $1.value }
        return sortedScores.first?.key ?? "Desconocido"
    }
    
    func getButtonColor(index: Int) -> Color {
        let colors: [Color] = [.red, .green, .blue, .orange]
        return colors[index % colors.count]
    }
}
