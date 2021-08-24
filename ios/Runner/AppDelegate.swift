import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController;
    let batteryChannel  = FlutterMethodChannel(name: "flutter.dev/home-screen", binaryMessenger: controller.binaryMessenger);
    
    batteryChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        guard call.method == "getBatteryLevel" else {
            result(FlutterMethodNotImplemented)
            return
        }
        self.receiveBatteryLevel(result: result)
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func receiveBatteryLevel(result: FlutterResult) {
        let device = UIDevice.current;
        device.isBatteryMonitoringEnabled = true;
        if device.batteryState == UIDevice.BatteryState.unknown {
            result(FlutterError(code: "UNAVAILABLE", message: "Battery info unavailable", details: nil))
        }else{
            result(Int(device.batteryLevel * 100))
        }
    }
}
