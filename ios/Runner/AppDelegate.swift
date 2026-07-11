import Flutter
import UIKit

// This app displays cryptographic secrets (mnemonics/seeds/shares). iOS
// snapshots the current screen content to show in the app switcher
// ("Recent Apps") every time the app resigns active. We cover the UI with
// an opaque overlay just before that snapshot is taken, and remove it once
// the app is foreground again, so secrets never end up in that snapshot
// (which is also cached to disk by the system).
@main
@objc class AppDelegate: FlutterAppDelegate {
  private var privacyOverlay: UIView?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func applicationWillResignActive(_ application: UIApplication) {
    addPrivacyOverlay()
    super.applicationWillResignActive(application)
  }

  override func applicationDidBecomeActive(_ application: UIApplication) {
    removePrivacyOverlay()
    super.applicationDidBecomeActive(application)
  }

  private func addPrivacyOverlay() {
    guard privacyOverlay == nil, let window = self.window else { return }
    let overlay = UIView(frame: window.bounds)
    overlay.backgroundColor = .black
    overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    window.addSubview(overlay)
    privacyOverlay = overlay
  }

  private func removePrivacyOverlay() {
    privacyOverlay?.removeFromSuperview()
    privacyOverlay = nil
  }
}
