//
//  ShoeController.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import SwiftUI

class ShoeController: ObservableObject {
    @Published var shoes: [Shoe] = []
    
    init() {
        loadSampleData()
    }
    
    private func loadSampleData() {
        shoes = [
            Shoe(sku: "NK001", name: "Nike Air Max", price: 129.99, color: "Blanco/Rojo", size: 42, gender: .hombre, type: .deportivo, imageName: "shoe1"),
            Shoe(sku: "AD002", name: "Adidas Superstar", price: 89.99, color: "Negro", size: 38, gender: .mujer, type: .casual, imageName: "shoe2"),
            Shoe(sku: "CN003", name: "Converse Chuck Taylor", price: 59.99, color: "Rojo", size: 40, gender: .unisex, type: .casual, imageName: "shoe3"),
            Shoe(sku: "PN004", name: "Puma RS-X", price: 109.99, color: "Azul", size: 41, gender: .hombre, type: .deportivo, imageName: "shoe4"),
            Shoe(sku: "VK005", name: "Vans Old Skool", price: 69.99, color: "Negro/Blanco", size: 39, gender: .unisex, type: .casual, imageName: "shoe5"),
            Shoe(sku: "CL006", name: "Clarks Desert Boot", price: 119.99, color: "Café", size: 43, gender: .hombre, type: .formal, imageName: "shoe6"),
            Shoe(sku: "DR007", name: "Dr. Martens 1460", price: 149.99, color: "Negro", size: 37, gender: .mujer, type: .botas, imageName: "shoe7"),
            Shoe(sku: "SK008", name: "Skechers Go Walk", price: 79.99, color: "Gris", size: 36, gender: .mujer, type: .casual, imageName: "shoe8"),
            Shoe(sku: "NB009", name: "New Balance 574", price: 89.99, color: "Azul Marino", size: 44, gender: .hombre, type: .deportivo, imageName: "shoe9"),
            Shoe(sku: "BR010", name: "Birkenstock Arizona", price: 99.99, color: "Marrón", size: 39, gender: .unisex, type: .sandalias, imageName: "shoe10")
        ]
    }
    
    func filterByGender(_ gender: Shoe.Gender) -> [Shoe] {
        shoes.filter { $0.gender == gender }
    }
    
    func filterByType(_ type: Shoe.ShoeType) -> [Shoe] {
        shoes.filter { $0.type == type }
    }
}

