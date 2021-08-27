//
//  SceneDelegate.swift
//  PartnerIntegration
//
//  Created by Nuno Salvador on 06/11/2020.
//  Copyright © 2020 Celfocus. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let scheme = "deeplinks"

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        // either one will work
        if let url = connectionOptions.urlContexts.first?.url {
            handle(url: url)
        }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        // first launch after install
        if let url = URLContexts.first?.url {
            handle(url: url)
        }
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        // when in background mode
        if let url = userActivity.webpageURL {
            handle(url: url)
        }
    }

    func handle(url: URL) {
        let controller = window?.rootViewController as! HomeController
        // handle url
        switch url.absoluteString {
        case "\(scheme)://homepage": controller.goHomeController()

        default: break
        }
    }

}

