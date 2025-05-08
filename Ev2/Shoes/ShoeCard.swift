//
//  ShoeCard.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import SwiftUI

struct ShoeCardView: View {
    let shoe: Shoe
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "shoe.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue)
                .padding(10)
                .background(Color(.systemGray5))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(shoe.name)
                    .font(.headline)
                
                Text(shoe.formattedPrice)
                    .font(.subheadline)
                    .foregroundColor(.green)
                
                HStack {
                    Text("Talla: \(shoe.size)")
                    Text("•")
                    Text(shoe.color)
                }
                .font(.caption)
                .foregroundColor(.secondary)
                
                HStack(spacing: 5) {
                    Text(shoe.gender.rawValue)
                        .padding(3)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(3)
                    
                    Text(shoe.type.rawValue)
                        .padding(3)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(3)
                }
                .font(.caption2)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
