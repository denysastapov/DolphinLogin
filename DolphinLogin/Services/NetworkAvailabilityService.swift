//
//  NetworkAvailabilityService.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 15.11.2023.
//

import Network

protocol NetworkAvailabilityServiceDelegate: AnyObject {
    func networkStatusDidChange(_ isConnected: Bool)
}

class NetworkAvailabilityService {
    static let shared = NetworkAvailabilityService()

    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()

    weak var delegate: NetworkAvailabilityServiceDelegate?

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
