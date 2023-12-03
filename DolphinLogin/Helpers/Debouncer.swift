//
//  Debouncer.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 03.12.2023.
//

import Foundation

class Debouncer {
    private let timeInterval: TimeInterval
    private var timer: Timer?

    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }

    func execute(action: @escaping () -> Void) {
        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
            action()
        }
    }
}
