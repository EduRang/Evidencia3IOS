//
//  Shoe.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import Foundation

struct Shoe: Identifiable, Hashable, Equatable {
    let id = UUID()
    let sku: String
    let name: String
    let price: Double
    let color: String
    let size: Int
    let gender: Gender
    let type: ShoeType
    let imageName: String
    
    enum Gender: String, CaseIterable {
        case hombre = "Hombre"
        case mujer = "Mujer"
        case unisex = "Unisex"
    }
    
    enum ShoeType: String, CaseIterable {
        case deportivo = "Deportivo"
        case casual = "Casual"
        case formal = "Formal"
        case botas = "Botas"
        case sandalias = "Sandalias"
    }
    
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: price)) ?? String(format: "$%.2f", price)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(sku)
    }
    
    static func == (lhs: Shoe, rhs: Shoe) -> Bool {
        return lhs.id == rhs.id && lhs.sku == rhs.sku
    }
}
