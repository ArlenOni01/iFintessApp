//
//  PhoneSessionCoordinator.swift
//  TrainingApp
//

import Foundation
import WatchConnectivity

// Phone side of the Watch link: pushes the last-used config for each drill type
// down via application context (so the Watch always has a sane default even if
// it wasn't reachable at send time), and relays finished-session results back
// from the Watch into the app's own persistence layer via `onResultReceived`.
final class PhoneSessionCoordinator: NSObject, ObservableObject, WCSessionDelegate {
    static let shared = PhoneSessionCoordinator()

    @Published private(set) var isWatchAppInstalled = false

    var onResultReceived: ((DrillResultPayload) -> Void)?

    private var sentConfigs: [String: Data] = [:]

    private override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }

    func send(config payload: DrillConfigPayload) {
        guard let data = try? JSONEncoder().encode(payload) else { return }
        sentConfigs[payload.drillType] = data
        try? WCSession.default.updateApplicationContext(["configs": sentConfigs])
    }

    private func handleIncoming(_ dict: [String: Any]) {
        guard let data = dict["drillResult"] as? Data,
              let payload = try? JSONDecoder().decode(DrillResultPayload.self, from: data) else { return }
        DispatchQueue.main.async { self.onResultReceived?(payload) }
    }

    // MARK: - WCSessionDelegate

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async { self.isWatchAppInstalled = session.isWatchAppInstalled }
    }

    func sessionWatchStateDidChange(_ session: WCSession) {
        DispatchQueue.main.async { self.isWatchAppInstalled = session.isWatchAppInstalled }
    }

    func sessionDidBecomeInactive(_ session: WCSession) {}

    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }

    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String: Any] = [:]) {
        handleIncoming(userInfo)
    }

    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        handleIncoming(message)
    }
}
