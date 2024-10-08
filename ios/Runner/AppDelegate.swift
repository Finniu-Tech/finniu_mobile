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
  //url schemes
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return handleDeepLink(url)
  }

  // deep links
  private func handleDeepLink(_ url: URL) -> Bool {
    print("Recibido deep link: \(url)")

    // get FlutterViewController
    guard let flutterViewController = window?.rootViewController as? FlutterViewController else {
      return false
    }

    // channel
    let channel = FlutterMethodChannel(name: "com.finniu.finniuapp/deeplink",
                                       binaryMessenger: flutterViewController.binaryMessenger)

    // send the url to flutter
    channel.invokeMethod("handleDeepLink", arguments: url.absoluteString)

    return true
  }
}