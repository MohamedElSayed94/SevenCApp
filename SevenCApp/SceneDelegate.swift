//
//  SceneDelegate.swift
//  SevenCApp
//
//  Created by Mohamed Elsayed on 31/10/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        adjustNavigationBarAppearence()
        window = UIWindow(windowScene: windowScene)
        let viewController = UINavigationController(rootViewController: HomeViewController(viewModel: HomeViewModel()))
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    

    func adjustNavigationBarAppearence() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }

}

