//
//  AppDelegate.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 알림 권한에 대한 설정
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            print(success, error)
        }
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

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Foreground에서 올리고 싶을 때 => willPresent
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // 특정 화면이나 특정 조건에서만 Foreground 알림 받기
        // 특정 화면에서는 알림을 받지 않기
        completionHandler([.sound, .badge, .banner, .list])
    }
    
    // 특정 푸시를 클릭하면 특정 화면으로 이동
    // 알림 개수를 제한 (64개로 제한 - UNNotificationRequest의 identifier)
    // 카톡 - foreground로 앱을 켜는 순간, 등록된 알림을 모두 제거
    // 잔디 - foreground로 앱을 켜도 나머지 알림이 모두 살아 있음
}
