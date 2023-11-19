//
//  Network.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 15.11.2023.
//

import Foundation
import Network

protocol NetworkMonitorDelegate: AnyObject {
    func networkStatusDidChange(_ isConnected: Bool)
}

class NetworkMonitor {
    static let shared = NetworkMonitor()

    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()

    weak var delegate: NetworkMonitorDelegate?

    private init() {
        monitor = NWPathMonitor()
    }

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            let isConnected = path.status == .satisfied
            self?.delegate?.networkStatusDidChange(isConnected)
        }

        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
