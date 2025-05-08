//
//  CambiarFondoView.swift
//  Ev2
//
//  Created by ALUMNO on 01/04/25.
//

import SwiftUI

struct CambiarFondoView: View {
    @State var edad = 0.0;
    @State var opacidad = 1.0;
    @State var fondo = false;
    @State var texto = "Cambiar texto";
    @State var controlTexto = false;
    @State var estilo = true;
    
    var body: some View {
        ZStack {
            if fondo {
                Color.red.brightness(0.60).ignoresSafeArea();
            }
            
            VStack {
                Button("Cambiar fondo"){
                    fondo = !fondo;
                }
                
                Button(texto){
                    controlTexto = !controlTexto;
                    if controlTexto {
                        texto = "Devolver texto"
                    } else {
                        texto = "Cambiar texto";
                    }
                }
                
                if estilo {
                    Button("Boton con estilo"){
                        estilo = !estilo;
                    }
                    .buttonStyle(BorderedButtonStyle())
                } else {
                    Button("Boton sin estilo"){
                        estilo = !estilo;
                    }
                    .buttonStyle(DefaultButtonStyle())
                }
                
                sliders
                
                images
            }
            .padding()
        }
    }
    
    var sliders: some View {
        VStack {
            Text("Edad: \(Int(edad))")
            Slider(value: $edad, in: 0...100, step: 1)
            
            Text("Opacidad: \(opacidad, specifier: "%.2f")")
            Slider(value: $opacidad, in: 0...1, step: 0.01)
        }
        .padding()
    }
    
    var images: some View {
        AsyncImage(url: URL(string: "https://i.pinimg.com/736x/38/72/a2/3872a24c92121c41787370b86c1dcc42.jpg"))
            { image in
                image.resizable()
                    .scaledToFit()
                    .opacity(opacidad)
            } placeholder: {
                ProgressView()
            }
    }
}
