//
//  VinosView.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import SwiftUI

struct VinosView: View {
    @State private var nombre = ""
    @State private var email = ""
    @State private var edad = ""
    
    @State private var clienteRegistrado: Cliente? = nil
    @State private var mostrarAlerta = false
    @State private var mensajeAlerta = ""

    var body: some View {
        if let cliente = clienteRegistrado {
            VinoView(cliente: cliente)
        } else {
            NavigationView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Registro de Cliente")
                        .font(.largeTitle)
                        .bold()

                    TextField("Nombre", text: $nombre)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)

                    TextField("Edad", text: $edad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)

                    Button(action: registrarCliente) {
                        Text("Registrarse")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Spacer()
                }
                .padding()
                .navigationTitle("Alta Cliente")
                .alert(isPresented: $mostrarAlerta) {
                    Alert(title: Text("Error"), message: Text(mensajeAlerta), dismissButton: .default(Text("OK")))
                }
            }
        }
    }

    func registrarCliente() {
        guard !nombre.isEmpty, !email.isEmpty, let edadInt = Int(edad), edadInt >= 18 else {
            mensajeAlerta = "Completa todos los campos correctamente. Edad mínima: 18."
            mostrarAlerta = true
            return
        }

        let nuevoCliente = Cliente(nombre: nombre, email: email, edad: edadInt)
        clienteRegistrado = nuevoCliente
    }
}
