//
//  Act9View.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import SwiftUI

struct Act9View: View {
    @StateObject private var appModel = AppStateModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("🧭 Ciclo de Vida de la App")
                    .font(.title2)
                    .bold()
                    .padding(.top)

                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(appModel.logs, id: \.self) { log in
                            LogEntryView(logText: log)
                                .transition(.slide)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Timeline de Eventos")
        }
    }
}
