//
//  ContentView.swift
//  Ev2
//
//  Created by ALUMNO on 01/04/25.
//

import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    var name: String
    var isCompleted: Bool = false
}

struct ContentView: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink {
                    CambiarFondoView()
                } label: {
                    Text("Act2")
                }
                NavigationLink {
                    ExamenBeatboxView()
                } label: {
                    Text("Act3")
                }
                NavigationLink {
                    ListaTareasView()
                } label: {
                    Text("Act4")
                }
                NavigationLink {
                    Act6View()
                } label: {
                    Text("Act6")
                }
                NavigationLink {
                    PerfilView()
                } label: {
                    Text("Act7")
                }
                NavigationLink {
                    TestView()
                } label: {
                    Text("Act8")
                }
                NavigationLink {
                    Act9View()
                } label: {
                    Text("Act9")
                }
                NavigationLink {
                    FavoriteAthleteView()
                } label: {
                    Text("Favorite Athlete")
                }
                NavigationLink {
                    ShoesView()
                } label: {
                    Text("Shoes")
                }
                NavigationLink {
                    SpyView()
                } label: {
                    Text("ISpy")
                }
                NavigationLink {
                    EmojisView()
                } label: {
                    Text("Emojis")
                }
                NavigationLink {
                    VinosView()
                } label: {
                    Text("Vinos")
                }
                NavigationLink {
                    EmployeeView()
                } label: {
                    Text("Employee")
                }
                
            }
        }
        .navigationBarBackButtonHidden(false)
    }
}

#Preview {
    ContentView()
}
