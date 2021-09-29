//
//  AppDelegate.swift
//  WikiRxSwiftHelloWorld
//
//  Created by yasushi saitoh on 2021/09/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //　グローバル宣言
    var CurrentVC = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //windowを生成
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        //Viewcontrollerを指定
        let initialViewController = WikiViewController.startVC()
        //rootViewControllerに入れる
        window?.rootViewController = initialViewController
        //表示
        window?.makeKeyAndVisible()
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

