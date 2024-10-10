import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
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
    
    // Get the deep link scheme for the current flavor
    let stagingScheme = "finniuappstaging"
    let productionScheme = "finniuapp"
    let currentScheme = Bundle.main.object(forInfoDictionaryKey: "DEEP_LINK_SCHEME") as? String ?? productionScheme
    
    if url.scheme == currentScheme || url.scheme == "https" {
      guard let flutterViewController = window?.rootViewController as? FlutterViewController else {
        return false
      }
      let channel = FlutterMethodChannel(name: "com.finniu.finniuapp/deeplink", binaryMessenger: flutterViewController.binaryMessenger)
      
      // Pass both the URL and the current flavor to the Dart side
      let flavorInfo = ["url": url.absoluteString, "flavor": currentScheme == stagingScheme ? "staging" : "production"]
      channel.invokeMethod("handleDeepLink", arguments: flavorInfo)
      
      return true
    }
    
    return false
  }
}