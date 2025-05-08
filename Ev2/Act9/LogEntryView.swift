//
//  LogEntryView.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import SwiftUI

struct LogEntryView: View {
    var logText: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            iconFor(logText)
                .font(.title2)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 4) {
                Text(logText)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }

    func iconFor(_ text: String) -> Image {
        if text.contains("Active") {
            return Image(systemName: "bolt.fill")
        } else if text.contains("Inactive") {
            return Image(systemName: "pause.circle.fill")
        } else if text.contains("Suspended") {
            return Image(systemName: "moon.stars.fill")
        } else if text.contains("Background") {
            return Image(systemName: "moon.fill")
        } else {
            return Image(systemName: "questionmark.circle")
        }
    }
}

