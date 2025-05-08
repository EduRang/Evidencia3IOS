//
//  ProfileView.swift
//  Ev2
//
//  Created by ALUMNO on 01/04/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: "https://i.pinimg.com/474x/dc/54/b3/dc54b30757d6c223cb8bb72ba41b3a75.jpg")) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            } placeholder: {
                ProgressView()
            }
            
            Text("Eduardo Rangel")
                .font(.largeTitle)
                .bold()
            
            Text("Nací el 22 de noviembre de 2004 en Chihuahua, Chihuahua, y actualmente vivo en Aldama desde el 2018. Tengo tres hermanas y un hermano, además de tres sobrinos.")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
    }
}
