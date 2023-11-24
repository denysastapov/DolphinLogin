//
//  SceneDelegate.swift
//  DolphinLogin
//
//  Created by Denys Astapov on 14.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let rootViewController = UINavigationController(rootViewController: LoginViewController())
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()
        
        NetworkAvailabilityService.shared.startMonitoring()
        
        func networkStatusDidChange(_ isConnected: Bool) {
            if !isConnected {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "No internet connection",
                                                  message: "Please check your network connection.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            }
        }
    }


}

