//
//  HobbiesvIEW.swift
//  Ev2
//
//  Created by ALUMNO on 01/04/25.
//

import SwiftUI

struct HobbiesView: View {
    let hobbies = [
        ("Leer Mangas", "https://www.planetadelibros.com/usuaris/libros/fotos/240/original/portada_nana-n-0121-nueva-edicion_ai-yazawa_201612131733.jpg"),
        ("Programar", "https://upload.wikimedia.org/wikipedia/commons/6/6a/JavaScript-logo.png"),
        ("Beatbox", "https://static.wikia.nocookie.net/beatbox/images/4/4e/Tomazacre_Grand_Beatbox_Battle_2019.jpg/revision/latest?cb=20200630161902")
    ]
    
    var body: some View {
        List(hobbies, id: \.0) { hobby, imageUrl in
            HStack {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                }
                
                Text(hobby)
                    .font(.title3)
                    .padding(.leading, 10)
            }
            .padding()
        }
    }
}
