//
//  Emoji.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import Foundation

struct Emoji: Identifiable, Codable {
    var id = UUID() // Esto asegura que cada Emoji tiene un identificador único
    var symbol: String
    var name: String
    var description: String

    // Método estático para obtener la URL de archivo
    static var archiveURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.appendingPathComponent("emojis.plist")
    }

    // Método estático para guardar emojis en un archivo
    static func saveToFile(emojis: [Emoji]) {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(emojis)
            try data.write(to: archiveURL)
        } catch {
            print("Error al guardar emojis: \(error)")
        }
    }

    // Método estático para cargar emojis desde el archivo
    static func loadFromFile() -> [Emoji] {
        let decoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: archiveURL)
            let emojis = try decoder.decode([Emoji].self, from: data)
            return emojis
        } catch {
            print("Error al cargar emojis: \(error)")
            return []
        }
    }

    // Método estático para proporcionar una colección de Emojis de ejemplo
    static func sampleEmojis() -> [Emoji] {
        return [
            Emoji(symbol: "😀", name: "Grinning Face", description: "A grinning face emoji."),
            Emoji(symbol: "😎", name: "Sunglasses", description: "A cool face with sunglasses."),
            Emoji(symbol: "❤️", name: "Heart", description: "A red heart emoji."),
        ]
    }
}

