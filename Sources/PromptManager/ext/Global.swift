#if os(iOS)
import SwiftUI
import UIKit
/**
 * rootController (Better support for SwiftUI) (iOS only)
 * - Abstract: A RootController variable that can be accessed from anywhere
 * - Description: This variable provides a reference to the root view controller of the key window, which can be used for presenting modal view controllers or accessing the current top view controller in the view hierarchy.
 * - Note: Alternative name: `presentedViewController`
 * - Fixme: ⚠️️ seems like this has some issue now, causiing lldb error etc
 *
 * - Example:
 * ```
 * if let rootController = rootController {
 *     let alertController = UIAlertController(title: "Alert", message: "This is an alert", preferredStyle: .alert)
 *     alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
 *     rootController.present(alertController, animated: true, completion: nil)
 * }
 * ```
 * - Returns: The root view controller of the app, which can be used to present alerts or access the root view controller.
 */
internal var rootController: UIViewController? {
   // Retrieve the key window of the app
   let keyWin: UIWindow? = keyWin
   // Initialize the root view controller with the root view controller of the key window
   var root: UIViewController? = keyWin?.rootViewController
   // Loop through the presented view controllers to find the topmost presented view controller
   while let presentedViewController: UIViewController = root?.presentedViewController {
      root = presentedViewController
   }
   // Return the topmost presented view controller
   return root
}
/**
 * A convenience function that retrieves the key window of the app on iOS devices.
 * - Description: This function can be used to access the key window of the app on iOS devices. For example, you can use it to present a custom alert or to access the root view controller.
 * - Example:
 * ```
 * if let keyWindow = keyWin {
 *     let rootViewController = keyWindow.rootViewController
 *     rootViewController?.present(alertController, animated: true, completion: nil)
 * }
 * ```
 */
internal var keyWin: UIWindow? {
   UIApplication.shared.connectedScenes // Retrieves all connected scenes of the app
      .compactMap { $0 as? UIWindowScene } // Converts each scene to UIWindowScene if possible
      .flatMap { $0.windows } // Flattens the array of windows for each scene into a single array
      .first { $0.isKeyWindow } // Finds the first window that is the key window
}
#endif
