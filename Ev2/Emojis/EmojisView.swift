//
//  EmojisView.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import SwiftUI

struct EmojisView: View {
    @State private var emojis: [Emoji] = []
    @State private var newEmojiSymbol = ""
    @State private var newEmojiName = ""
    @State private var newEmojiDescription = ""
    @State private var selectedEmoji: String? = nil // Track the selected emoji

    // Emojis predefinidos para seleccionar
    let emojiChoices = ["😀", "😎", "❤️"]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(emojis) { emoji in
                        HStack {
                            Text(emoji.symbol)
                                .font(.largeTitle)
                                .padding()
                                .background(self.selectedEmoji == emoji.symbol ? Color.blue.opacity(0.2) : Color.clear) // Highlight selected emoji
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(self.selectedEmoji == emoji.symbol ? Color.blue : Color.clear, lineWidth: 2) // Border color
                                )
                                .onTapGesture {
                                    // Select emoji
                                    selectedEmoji = emoji.symbol
                                }

                            VStack(alignment: .leading) {
                                Text(emoji.name)
                                    .font(.headline)
                                Text(emoji.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            // Trash button
                            Button(action: {
                                // Present a confirmation alert before deleting
                                deleteEmojiConfirmation(emoji: emoji)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                    .padding(5)
                                    .background(Circle().fill(Color.gray.opacity(0.2)))
                            }
                        }
                        .padding(.vertical, 5)
                    }
                    .onDelete(perform: deleteEmoji)
                }
                .navigationTitle("Emojis")
                
                // Formulario para agregar un nuevo emoji
                Form {
                    Section(header: Text("New Emoji")) {
                        // Mostramos los 3 emojis clickeables
                        HStack {
                            ForEach(emojiChoices, id: \.self) { emoji in
                                Text(emoji)
                                    .font(.largeTitle)
                                    .padding()
                                    .background(self.selectedEmoji == emoji ? Color.blue.opacity(0.2) : Color.clear) // Resaltar emoji seleccionado
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(self.selectedEmoji == emoji ? Color.blue : Color.clear, lineWidth: 2) // Borde al seleccionar
                                    )
                                    .onTapGesture {
                                        // Al hacer clic en un emoji, se asigna al campo de texto
                                        newEmojiSymbol = emoji
                                        selectedEmoji = emoji // Marca el emoji como seleccionado
                                    }
                            }
                        }
                        
                        TextField("Name", text: $newEmojiName)
                        TextField("Description", text: $newEmojiDescription)
                        
                        Button("Save Emoji") {
                            saveEmoji()
                        }
                    }
                }
                .padding()
            }
            .onAppear(perform: loadEmojis)
        }
    }

    // Cargar los emojis al iniciar
    func loadEmojis() {
        emojis = Emoji.loadFromFile()
    }

    // Guardar un nuevo emoji
    func saveEmoji() {
        guard !newEmojiSymbol.isEmpty else { return } // No permitir guardar si no se seleccionó un emoji

        let newEmoji = Emoji(symbol: newEmojiSymbol, name: newEmojiName, description: newEmojiDescription)
        emojis.append(newEmoji)
        Emoji.saveToFile(emojis: emojis)
        resetForm()
    }

    // Eliminar un emoji
    func deleteEmoji(at offsets: IndexSet) {
        emojis.remove(atOffsets: offsets)
        Emoji.saveToFile(emojis: emojis)
    }

    // Confirmación para eliminar un emoji
    func deleteEmojiConfirmation(emoji: Emoji) {
        let alertController = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this emoji?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            if let index = self.emojis.firstIndex(where: { $0.id == emoji.id }) {
                self.emojis.remove(at: index)
                Emoji.saveToFile(emojis: self.emojis)
            }
        }))
        
        if let rootVC = UIApplication.shared.windows.first?.rootViewController {
            rootVC.present(alertController, animated: true)
        }
    }

    // Limpiar los campos del formulario
    func resetForm() {
        newEmojiSymbol = ""
        newEmojiName = ""
        newEmojiDescription = ""
        selectedEmoji = nil
    }
}
