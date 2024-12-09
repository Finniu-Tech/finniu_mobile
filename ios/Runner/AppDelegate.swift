import UIKit
import Flutter
import flutter_local_notifications


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
                  completionHandler([.alert, .badge, .sound])
  }
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.finniu/deeplink", binaryMessenger: controller.binaryMessenger)
    
    // GeneratedPluginRegistrant.register(with: self)


    //local notification config
   
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
    }

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)


  }

  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return handleDeepLink(url)
  }

  override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    if let url = userActivity.webpageURL {
      return handleDeepLink(url)
    }
    return false
  }

  private func handleDeepLink(_ url: URL) -> Bool {
    print("Received deep link: \(url)")
    
    guard let controller = window?.rootViewController as? FlutterViewController else {
      return false
    }
    
    let channel = FlutterMethodChannel(name: "com.finniu/deeplink", binaryMessenger: controller.binaryMessenger)
    channel.invokeMethod("handleDeepLink", arguments: url.absoluteString)
    
    return true
  }
}