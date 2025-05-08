//
//  RegisterView.swift
//  Ev2
//
//  Created by ALUMNO on 01/04/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var mail: String = ""
   
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
   
    @Environment(\.dismiss) var dismiss
    @State private var navigateToLogin = false
   
    let logoURL = "https://i.pinimg.com/564x/10/99/24/109924bea8f8d1e1c5d6cdb9da0307d8.jpg"
    var passwordsMatch: Bool {
        return !password.isEmpty && password == confirmPassword
    }
    var fieldsNotEmpty: Bool {
        return !username.isEmpty && !mail.isEmpty
    }
    var body: some View {
        NavigationStack {
            AsyncImage(url: URL(string: logoURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } placeholder: {
                ProgressView()
            }
            .padding(.bottom, 40)
            
            VStack(alignment: .leading, spacing: 15) {
                TextField("Username", text: $username)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder())
                TextField("Mail", text: $mail)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder())
                if fieldsNotEmpty {
                    SecureField("Password", text: $password)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder())
                    if !password.isEmpty {
                        SecureField("Confirm Password", text: $confirmPassword)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 5).strokeBorder())
                        if !passwordsMatch && !confirmPassword.isEmpty {
                            Text("Passwords must match")
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.top, 5)
                        }
                    }
                    Button(action: {
                        navigateToLogin = true
                    }) {
                        Text("Register")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(passwordsMatch ? Color.blue : Color.gray)
                            .cornerRadius(10)
                    }
                    .disabled(!passwordsMatch)
                }
            }
            .padding()
            .navigationDestination(isPresented: $navigateToLogin) {
                JohnPorkView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}
