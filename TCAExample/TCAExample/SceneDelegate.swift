//
//  SceneDelegate.swift
//  TCAExample
//
//  Created by Van Simmons on 7/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import UIKit
import SwiftUI
import ComposableArchitecture

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let contentView = ContentView(
            store: Store(
                initialState: AppState(),
                reducer: reducer,
                environment: AppEnvironment()
            )
        )

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}

