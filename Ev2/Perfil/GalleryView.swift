//
//  GalleryvIEW.swift
//  Ev2
//
//  Created by ALUMNO on 01/04/25.
//

import SwiftUI

struct GalleryView: View {
    let images = [
        "https://i.pinimg.com/474x/91/d9/23/91d9230906b59ca7367c22abd9be1c73.jpg",
        "https://ih1.redbubble.net/image.5368525560.5696/raf,360x360,075,t,fafafa:ca443f4786.jpg",
        "https://ntvb.tmsimg.com/assets/assets/157012_v9_bd.jpg?w=360&h=480",
        "https://supercell.com/images/e6ed3de4f9978a4b922b009e9c2a9547/sccom_haaland_article1.webp",
        "https://preview.redd.it/gctffk05y21c1.png?auto=webp&s=36e8648e614c4c979b9d70b0f946be033b5f3f10",
        "https://image-cdn-ak.spotifycdn.com/image/ab67706c0000da84842dc3b64a78a89e2ad4ffab"
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(images, id: \.self) { image in
                    AsyncImage(url: URL(string: image)) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 5)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            .padding()
        }
    }
}
