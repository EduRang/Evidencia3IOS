//
//  ResultadoView.swift
//  Ev2
//
//  Created by ALUMNO on 01/04/25.
//

import SwiftUI

struct ResultadoView: View {
    let result: String
    
    var body: some View {
        VStack(spacing: 20) {
            // Imagen del jugador
            AsyncImage(url: URL(string: getPlayerImage(result: result))) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .padding()
                        .shadow(radius: 10)
                case .failure:
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            
            // Título con nombre del jugador
            VStack {
                Text("Eres:")
                    .font(.title)
                    .bold()
                
                Text(result)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(getPlayerColor(result: result))
            }
            .padding(.vertical)
            
            // Descripción personalizada
            Text(getPlayerDescription(result: result))
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
        }
    }
    
    // Obtiene la imagen del jugador
    func getPlayerImage(result: String) -> String {
        let images = [
            "CR7": "https://media.gq.com.mx/photos/66774829c12a54a09ddc8b23/1:1/w_2012,h_2012,c_limit/Cristiano%20Ronaldo.jpg",
            "Messi": "https://c.files.bbci.co.uk/aae8/live/96342340-037d-11f0-8c73-11881f60ccb3.png",
            "Iniesta": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRem69yp641XlNsh-B7UGyj5MvuzoVmuFtuQg&s",
            "Neuer": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvGU9semIMRZnVDKkhPlVZ7ZxoMkHHxmoqrA&s"
        ]
        return images[result] ?? ""
    }
    
    // Obtiene la descripción del jugador
    func getPlayerDescription(result: String) -> String {
        let descriptions = [
            "CR7": "¡Eres un goleador nato como Cristiano Ronaldo! Tu determinación, disciplina y hambre de éxito te definen. Tienes una ética de trabajo impecable y siempre buscas superarte a ti mismo. Tu actitud ganadora y tu habilidad para marcar en los momentos clave te hacen un jugador invaluable.",
            "Messi": "¡Tienes el talento natural de Lionel Messi! Tu creatividad, visión de juego y habilidad técnica son excepcionales. Juegas con elegancia y sencillez, pero con una efectividad demoledora. Eres humilde pero letal en el terreno de juego, capaz de decidir partidos con un momento de genialidad.",
            "Iniesta": "¡Eres el cerebro del equipo como Andrés Iniesta! Tu inteligencia táctica, control del juego y precisión en el pase te hacen indispensable. Sabes leer el juego como nadie y siempre apareces en el momento justo. Eres un líder silencioso que hace que todo funcione a la perfección.",
            "Neuer": "¡Eres un revolucionario del arco como Manuel Neuer! Has redefinido lo que significa ser portero con tu juego de pies y tu capacidad para salir del área. Eres seguro, dominas el área y eres el primer atacante y el último defensor. Tu presencia impone respeto en todo el campo."
        ]
        return descriptions[result] ?? "Eres un jugador único con habilidades especiales que te hacen destacar en el campo."
    }
    
    // Obtiene el color asociado al jugador
    func getPlayerColor(result: String) -> Color {
        let colors = [
            "CR7": Color(red: 0.8, green: 0.1, blue: 0.1),  // Rojo CR7
            "Messi": Color(red: 0.1, green: 0.3, blue: 0.8),  // Azul Messi
            "Iniesta": Color(red: 0.7, green: 0.1, blue: 0.1),  // Rojo Iniesta
            "Neuer": Color(red: 0.1, green: 0.5, blue: 0.2)   // Verde Neuer
        ]
        return colors[result] ?? .blue
    }
}

