//
//  SceneDelegate.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 14.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let networService = NetworkService()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let loginViewModel = LoginViewModel(networkService: networService)
        let loginViewController = LoginViewController()
        loginViewController.viewModelLogin = loginViewModel
        let rootViewController = UINavigationController(rootViewController: loginViewController)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()

        NetworkAvailabilityService.shared.startMonitoring()

        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusDidChange(_:)), name: .networkStatusChanged, object: nil)
    }

    @objc func networkStatusDidChange(_ notification: Notification) {
        if let isConnected = notification.userInfo?["isConnected"] as? Bool, !isConnected {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "No internet connection",
                                              message: "Please check your network connection.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
}
extension NSNotification.Name {
    static let networkStatusChanged = NSNotification.Name(rawValue: "networkStatusChanged")
}
