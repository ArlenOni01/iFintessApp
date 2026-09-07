//
//  WatchSessionCoordinator.swift
//  TrainingApp Watch App Watch App
//

import Combine
import Foundation
import WatchConnectivity

// Watch side of the phone link: receives the last-used config per drill type
// (delivered via application context, so it's there even if the phone wasn't
// reachable when it was sent) and reports finished sessions back to the phone
// via transferUserInfo, which queues reliably instead of requiring the phone
// to be reachable right at that instant.
final class WatchSessionCoordinator: NSObject, ObservableObject, WCSessionDelegate {
    static let shared = WatchSessionCoordinator()

    @Published private(set) var configs: [String: DrillConfigPayload] = [:]

    private override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }

    func send(result payload: DrillResultPayload) {
        guard let data = try? JSONEncoder().encode(payload) else { return }
        WCSession.default.transferUserInfo(["drillResult": data])
    }

    private func applyContext(_ context: [String: Any]) {
        guard let configsData = context["configs"] as? [String: Data] else { return }
        var decoded: [String: DrillConfigPayload] = [:]
        for (key, data) in configsData {
            if let payload = try? JSONDecoder().decode(DrillConfigPayload.self, from: data) {
                decoded[key] = payload
            }
        }
        DispatchQueue.main.async { self.configs = decoded }
    }

    // MARK: - WCSessionDelegate

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        applyContext(session.receivedApplicationContext)
    }

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        applyContext(applicationContext)
    }
}
