//
//  AppTestModel.swift
//  Ev2
//
//  Created by ALUMNO on 08/05/25.
//

import SwiftUI

class AppStateModel: ObservableObject {
    @Published var logs: [String] = []

    private var suspendTimer: Timer?

    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidBecomeActive),
                                               name: UIScene.didActivateNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appWillResignActive),
                                               name: UIScene.willDeactivateNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidEnterBackground),
                                               name: UIScene.didEnterBackgroundNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appWillEnterForeground),
                                               name: UIScene.willEnterForegroundNotification,
                                               object: nil)
    }

    @objc private func appDidBecomeActive() {
        cancelSuspendTimer()
        addLog("🟢 App esta Active")
    }

    @objc private func appWillResignActive() {
        addLog("🟡 App esta Inactive")
    }

    @objc private func appDidEnterBackground() {
        addLog("🔵 App en Background")

        // Inicia un temporizador de 5 segundos para "sospechar" de suspensión
        suspendTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
            self?.addLog("⚠️ Posible estado Suspended tras mas de 5 segundos en Background")
        }
    }

    @objc private func appWillEnterForeground() {
        cancelSuspendTimer()
        addLog("🟠 App volviendo a Active")
    }

    private func cancelSuspendTimer() {
        suspendTimer?.invalidate()
        suspendTimer = nil
    }

    private func addLog(_ text: String) {
        DispatchQueue.main.async {
            self.logs.insert("[\(self.timestamp())] \(text)", at: 0)
        }
    }

    private func timestamp() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter.string(from: Date())
    }
}
