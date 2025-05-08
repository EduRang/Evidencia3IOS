//
//  JohnPorkView.swift
//  Ev2
//
//  Created by ALUMNO on 01/04/25.
//

import SwiftUI

struct JohnPorkView: View {
    let imageURL = "https://cdn.prod.website-files.com/5d7e8885cad5174a2fcb98d7/64933f98a477f02e36a282d1_5eddd950e5cf1ec1fa5c2d83_virtual-influencer-john-pork.jpeg"
   
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } placeholder: {
                    ProgressView()
                }
                
                Spacer()
                
                Button("Back to Login") {
                    dismiss()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
            .navigationBarBackButtonHidden(false)
        }
    }
}
