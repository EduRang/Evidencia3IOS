//
//  ShoeDetail.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import SwiftUI

struct ShoeDetailView: View {
    let shoe: Shoe
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(systemName: "shoe.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(15)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(shoe.name)
                        .font(.title.bold())
                    
                    Text(shoe.formattedPrice)
                        .font(.title2)
                        .foregroundColor(.green)
                    
                    Divider()
                    
                    detailRow(title: "SKU", value: shoe.sku)
                    detailRow(title: "Color", value: shoe.color)
                    detailRow(title: "Talla", value: "\(shoe.size)")
                    detailRow(title: "Género", value: shoe.gender.rawValue)
                    detailRow(title: "Tipo", value: shoe.type.rawValue)
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle("Detalles")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func detailRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.body.bold())
        }
    }
}

