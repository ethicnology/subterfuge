import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ notification: Notification) {
    super.applicationDidFinishLaunching(notification)
    // This app displays cryptographic secrets (mnemonics/seeds/shares).
    // NSWindowSharingType.none excludes the window's content from
    // screenshots, screen recording, and screen sharing/casting on macOS.
    for window in NSApplication.shared.windows {
      window.sharingType = .none
    }
  }
}
