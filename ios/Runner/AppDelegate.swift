import UIKit
import Flutter
import amap_core_fluttify
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//    错误信息：apiKey为空，请正确设置AMapServices.apiKey。请在 AppDelegate.m 文件的 didFinishLaunchingWithOptions 方法中配置高德 Key。
    AMapServices.shared()?.apiKey = "3fd0355653988186e2edd8cd07974f03"
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
