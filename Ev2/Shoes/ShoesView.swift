//
//  ShoesView.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import SwiftUI

struct ShoesView: View {
    @StateObject private var shoeController = ShoeController()
    @State private var selectedGender: Shoe.Gender? = nil
    @State private var selectedType: Shoe.ShoeType? = nil
    @State private var showFilters = false
    
    var filteredShoes: [Shoe] {
        var result = shoeController.shoes
        
        if let gender = selectedGender {
            result = result.filter { $0.gender == gender }
        }
        
        if let type = selectedType {
            result = result.filter { $0.type == type }
        }
        
        return result
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Encabezado
                    headerView
                    
                    // Filtros (opcional)
                    if showFilters {
                        filterView
                    }
                    
                    // Lista de zapatos
                    shoesListView
                }
                .padding()
            }
            .navigationTitle("Catálogo de Zapatos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showFilters.toggle()
                    }) {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
    }
    
    private var headerView: some View {
        VStack(alignment: .leading) {
            Text("Colección")
                .font(.title.bold())
            Text("\(filteredShoes.count) modelos disponibles")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var filterView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Filtros")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Shoe.Gender.allCases, id: \.self) { gender in
                        Button(action: {
                            selectedGender = selectedGender == gender ? nil : gender
                        }) {
                            Text(gender.rawValue)
                                .padding(8)
                                .background(selectedGender == gender ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(selectedGender == gender ? .white : .primary)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Shoe.ShoeType.allCases, id: \.self) { type in
                        Button(action: {
                            selectedType = selectedType == type ? nil : type
                        }) {
                            Text(type.rawValue)
                                .padding(8)
                                .background(selectedType == type ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(selectedType == type ? .white : .primary)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
    
    private var shoesListView: some View {
        LazyVStack(spacing: 15) {
            ForEach(filteredShoes) { shoe in
                NavigationLink(destination: ShoeDetailView(shoe: shoe)) {
                    ShoeCardView(shoe: shoe)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
