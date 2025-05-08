//
//  Act6View.swift
//  Ev2
//
//  Created by ALUMNO on 01/04/25.
//

import SwiftUI

struct Act6View: View {
    @State private var username: String = ""
    @State private var password: String = ""
   
    var loginOk: Bool {
        return !username.isEmpty && !password.isEmpty
    }
   
    let logoURL = "https://i.pinimg.com/564x/10/99/24/109924bea8f8d1e1c5d6cdb9da0307d8.jpg"
   
    var body: some View {
        NavigationStack {
            VStack {
                AsyncImage(url: URL(string: logoURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                } placeholder: {
                    ProgressView()
                }
                .padding(.bottom, 40)
                
                TextField("Username/Mail", text: $username)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder())
                    .padding(.bottom, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder())
                    .padding(.bottom, 20)
                
                NavigationLink(
                    destination: JohnPorkView()
                ) {
                    Text("Log In")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(loginOk ? Color.blue : Color.gray)
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
                .disabled(!loginOk)
                
                NavigationLink(destination: RegisterView()) {
                    Text("Don't have an account? Register")
                        .foregroundColor(.blue)
                }
                .padding(.bottom, 10)
                
                NavigationLink(destination: PasswordView()) {
                    Text("Forgot your password?")
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
    }
}
