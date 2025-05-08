//
//  ExamenBeatboxView.swift
//  Ev2
//
//  Created by ALUMNO on 01/04/25.
//

import SwiftUI

struct ExamenBeatboxView: View {
    @State var num: Int = 1
    @State var showResult: Bool = false
    @State var score: Int = 0
    @State var selectedOption: String? = nil

    let questions: [(question: String, options: [String], correctAnswer: String)] = [
        ("Primer campeon mundial de Beatbox:", ["Skiller", "Dharni", "Thom Thum", "Roxorloops"], "Roxorloops"),
        ("Donde va a ser el proximo mundial de Beatbox:", ["EUA", "Francia", "Japon", "Polonia"], "Japon"),
        ("Actual campeon mundial:", ["Julard", "Tomazacre", "Dlow", "Napom"], "Julard"),
        ("Pais con mas titulos mundiales:", ["EUA", "Francia", "Corea del Sur", "Alemania"], "Francia"),
        ("Beatboxer con mas titulos mundiales:", ["Dharni", "River", "Alexinho", "Alem"], "Dharni"),
        ("", ["", "", "", ""], ""),
    ]
    
    var body: some View {
        VStack {
            Text("EXAMEN DE BEATBOX")
                .font(.largeTitle)
                .padding()
            
            if num < questions.count {
                let currentQuestion = questions[num - 1]
                
                Text("Pregunta \(num)")
                    .font(.title)
                    .padding()
                
                Text(currentQuestion.question)
                    .padding()
                    .multilineTextAlignment(.center)
                
                ForEach(currentQuestion.options, id: \.self) { option in
                    Button(action: {
                        if selectedOption == nil {
                            selectedOption = option
                        }
                    }) {
                        Text(option)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(option == selectedOption ? (option == currentQuestion.correctAnswer ? Color.green : Color.red) : (selectedOption != nil && option == currentQuestion.correctAnswer ? Color.green : Color.blue))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .disabled(selectedOption != nil)
                    }
                    .padding(.horizontal)
                }
                
                if selectedOption != nil {
                    Button(action: {
                        nextQuestion()
                    }) {
                        Text("Siguiente pregunta")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }
            } else {
                Text("¡Examen terminado!")
                    .font(.title)
                    .padding()
                Text("¡Sacaste \(score)/5!")
                if score > 4 {
                    Text("¡Aprobaste!")
                } else {
                    Text("¡Reprobaste!")
                }
                
                Button(action: {
                    retry()
                }){
                    Text("Volver a hacer el examen")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
    
    private func nextQuestion() {
        if selectedOption == questions[num - 1].correctAnswer {
            score += 1
        }
        selectedOption = nil
        num += 1
    }
    
    private func retry() {
        num = 1
        score = 0
    }
}
