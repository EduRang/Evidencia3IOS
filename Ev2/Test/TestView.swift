//
//  TestView.swift
//  Ev2
//
//  Created by ALUMNO on 01/04/25.
//

import SwiftUI

struct TestView: View {
    @State private var startQuiz = false
    
    var body: some View {
        NavigationView {
            VStack {
                AsyncImage(url: URL(string:  "https://i.ytimg.com/vi/xr2-jD3n6Q8/hqdefault.jpg?sqp=-oaymwEmCOADEOgC8quKqQMa8AEB-AH0BIAC3AOKAgwIABABGD8gYihlMA8=&rs=AOn4CLDuW41YGDOcPe5Vqcq9DQYVu8E2fg"))
                
                Text("¿Qué jugador de fútbol eres?")
                    .font(.largeTitle)
                    .padding()
                
                NavigationLink(destination: QuizView()) {
                    Text("Empezar Test")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
        }
    }
}
