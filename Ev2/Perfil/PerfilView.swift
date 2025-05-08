//
//  PerfilView.swift
//  Ev2
//
//  Created by ALUMNO on 01/04/25.
//

import SwiftUI

struct PerfilView: View {
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person.circle")
                }
            
            HobbiesView()
                .tabItem {
                    Label("Hobbies", systemImage: "star.fill")
                }
            
            GalleryView()
                .tabItem {
                    Label("Galería", systemImage: "photo.on.rectangle.angled")
                }
        }
    }
}
