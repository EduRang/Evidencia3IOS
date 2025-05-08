//
//  PasswordView.swift
//  Ev2
//
//  Created by ALUMNO on 01/04/25.
//

import SwiftUI

struct PasswordView: View {
    @State private var mail: String = ""
    @State private var confirmMail: Bool = false
   
    @State private var code: String = ""
    @State private var confirmCode: Bool = false
   
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
   
    var passwordsMatch: Bool {
        return !password.isEmpty && password == confirmPassword
    }
    let logoURL = "https://i.pinimg.com/564x/10/99/24/109924bea8f8d1e1c5d6cdb9da0307d8.jpg"
   
    var body: some View {
        NavigationView {
            VStack() {
                AsyncImage(url: URL(string: logoURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                } placeholder: {
                    ProgressView()
                }
                .padding(.bottom, 40)
                
                TextField("Recuperation mail", text: $mail)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder())
                    .onChange(of: mail) { newValue in
                        if newValue.isEmpty {
                            confirmMail = false
                            confirmCode = false
                            code = ""
                            password = ""
                            confirmPassword = ""
                        }
                    }
                Button(action: {
                    if !mail.isEmpty {
                        confirmMail = true
                    }
                }) {
                    Text("Confirm Mail")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                if confirmMail {
                    TextField("Recuperation code", text: $code)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder())
                    Button(action: {
                        if !code.isEmpty {
                            confirmCode = true
                        }
                    }) {
                        Text("Confirm Code")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .onChange(of: code) { newValue in
                        if newValue.isEmpty {
                            confirmCode = false
                            password = ""
                            confirmPassword = ""
                        }
                    }
                }
                if confirmCode {
                    SecureField("New Password", text: $password)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder())
                    if !password.isEmpty {
                        SecureField("Confirm New Password", text: $confirmPassword)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 5).strokeBorder())
                        if !passwordsMatch && !confirmPassword.isEmpty {
                            Text("Passwords must match")
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.top, 5)
                        }
                    }
                    NavigationLink(destination: ContentView()) {
                        Text("Register new password")
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
        }
    }
}
