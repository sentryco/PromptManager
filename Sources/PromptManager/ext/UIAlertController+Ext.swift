#if os(iOS)
import SwiftUI
import UIKit
/**
 * Consts
 * - Fixme: ⚠️️ Deperecate these?
 */
extension UIAlertController {
   /**
    * Define a type alias for a closure that takes no parameters and returns void, and name it "Cancel"
    */
   public typealias Cancel = () -> Void
   /**
    * Define a type alias for a closure that takes no parameters and returns void, and name it "OK"
    */
   public typealias OK = () -> Void
}
/**
 * Closure call for alert action
 * - Description: This typealias defines a closure that handles UIAlertAction events. It takes an UIAlertAction as a parameter and returns void.
 */
public typealias UIAlertActionHandler = (UIAlertAction) -> Void
/**
 * Closures for ok action and cancel action
 */
extension UIAlertAction {
   /**
    // Deprecated: This typealias will be removed in future versions.
    */
   public typealias OK = UIAlertActionHandler // Define a type alias for an UIAlertActionHandler closure and name it "OK"
   /**
    // Deprecated: This typealias will be removed in future versions.
    */
   public typealias Cancel = UIAlertActionHandler // Define a type alias for an UIAlertActionHandler closure and name it "Cancel"
}
/**
 * Alert extension
 */
extension UIAlertController {
   /**
    * Represents a closure that performs a completion task with no return value.
    * - Description: Represents a closure that is executed upon the completion of an operation, where no return value is expected.
    */
   public typealias Complete = () -> Void
   /**
    * Dismisses the alert controller on the main thread.
    * - Abstract: This method ensures that the alert controller is dismissed on the main thread to maintain UI consistency and avoid potential threading issues.
    * - Description: This method is used to dismiss the UIAlertController instance on the main thread. This is necessary to ensure that the UI updates consistently and avoids potential threading issues. The method takes two parameters, a boolean to indicate whether the dismissal should be animated and an optional completion closure that is called after the dismissal animation completes.
    * - Parameters:
    *   - animated: A Boolean value indicating whether the dismissal should be animated.
    *   - completion: An optional closure that gets called after the dismissal animation completes.
    */
   public func dismissOnMainThread(animated: Bool, completion: Complete? = nil) {
      DispatchQueue.main.async { [weak self] in // weakify - Perform the following block of code asynchronously on the main queue, and weakify self to avoid a retain cycle
         self?.dismiss(
            animated: true, // Set the animation flag to true, meaning the dismissal of the alert controller will be animated
            completion: completion // Set the completion handler to the provided closure, which will be called after the dismissal animation completes
         ) // Dismiss the current alert with the specified animation and completion handler
      }
   }
}
/**
 * Ext
 */
extension UIAlertController {
   /**
    * Create alert
    * - Description: This function creates an alert controller with the specified title, message, and action handlers. It allows for the creation of an alert with optional OK and Cancel buttons, each with their own handlers. The function returns the created alert controller.
    * ## Examples:
    * let alert = UIAlertController.createAlert(title: "Warning", ok: { _ in print("ok") }, cancelTitle: nil)
    * UIViewController.topMostController()?.present(alert, animated: true, completion: nil)
    * - Parameters:
    *   - title: Title to be displayed
    *   - msg: Message to be dispalyed
    *   - ok: Executed when user press OK (if nil, the btn is omitted)
    *   - cancel: Executed when user press Cancel (if nil, the btn is omitted)
    *   - okTitle: ok title
    *   - cancelTitle: cancel title
    * - Returns: The alert
    */
   public static func createAlert(title: String?, msg: String?, ok: UIAlertActionHandler? = nil, cancel: UIAlertActionHandler? = nil, okTitle: String? = "OK", cancelTitle: String? = "Cancel") -> UIAlertController {
      DispatchQueue.asyncIfNotMain { // Perform the following block of code asynchronously on a background queue if the current queue is not the main queue
         let ac = UIAlertController(
            title: title, // The title of the alert controller
            message: msg, // The message of the alert controller
            preferredStyle: .alert // The preferred style of the alert controller
         ) // Create a new alert controller with the specified title, message, and style
         if let okTitle = okTitle { // Check if an OK title is provided
            ac.addAction(
               // Creates an instance of UIAlertAction
               UIAlertAction(
                  title: okTitle, // The title of the OK action
                  style: .default, // The style of the OK action
                  handler: ok // The handler for the OK action
               )
            ) // Add an OK action to the alert controller with the specified title, style, and handler
         }
         if let cancelTitle = cancelTitle { // Check if a cancel title is provided
            ac.addAction(
               // Creates an instance of UIAlertAction
               UIAlertAction(
                  title: cancelTitle, // The title of the cancel action
                  style: .cancel, // The style of the cancel action
                  handler: cancel // The handler for the cancel action
               )
            ) // Add a cancel action to the alert controller with the specified title, style, and handler
         }
         return ac // Return the alert controller
      }
   }
   /**
    * Prompt alert
    * - Description: This function displays a prompt alert with the specified title, message, and action handlers. It allows for the creation of a prompt with optional OK and Cancel buttons, each with their own handlers. The function does not return anything but presents the alert on the main thread.
    * ## Examples:
    * UIAlertController.promptAlert(title: "Warning", msg: "An error has occured", ok: { _ in print("ok") }, cancelTitle: nil)
    * - Parameters:
    *   - title: Title to be displayed
    *   - msg: Message to be dispalyed
    *   - ok: Executed when user press OK (if nil, the btn is omitted)
    *   - cancel: Executed when user press Cancel (if nil, the btn is omitted)
    *   - okTitle: OK title
    *   - cancelTitle: Cancel title
    */
   public static func promptAlert(title: String, msg: String, ok: UIAlertActionHandler? = nil, cancel: UIAlertActionHandler? = nil, okTitle: String? = "OK", cancelTitle: String? = "Cancel")/* -> UIAlertController*/ {
      // ⚠️️ Quick fix for bug with asyncifnot main etc, figure it out later
      DispatchQueue.main.async { // Perform the following block of code asynchronously on the main queue
         let alert = UIAlertController.createAlert(
            title: title, // The title of the alert
            msg: msg, // The message of the alert
            ok: ok, // The handler for the OK action
            cancel: cancel, // The handler for the cancel action
            okTitle: okTitle, // The title of the OK action
            cancelTitle: cancelTitle // The title of the cancel action
         ) // Create a new alert controller with the specified title, message, actions, and titles
         // ⚠️️ Quick hack, use with uialert from ios 15 etc
         // let topVC = UIApplication.rootVC?.children.last // Get the top view controller from the root view controller's children
         /*topVC?*/rootController?.presentOnMainThread(
            alert, // The alert to present
            animated: true, // Whether to animate the presentation
            completion: nil // The completion handler to execute after the presentation finishes
         ) // Present the alert controller on the main thread with the specified animation and completion handler
      }
   }
   public typealias OnComplete = () -> Void
   /**
    * For attributed text
    * - Abstract: This function displays an alert with attributed title and message.
    * - Description: This function displays an alert with an attributed title and message. It allows for the creation of a prompt with optional OK and Cancel buttons, each with their own handlers. The function does not return anything but presents the alert on the main thread.
    * - Parameters:
    *   - attrTitle: attributed title
    *   - attrMSG: attributed message
    *   - ok: ok closure
    *   - cancel: cancel clsoure
    *   - okTitle: ok title
    *   - cancelTitle: cancel title
    * ## Examples:
    * let attrTitle = NSAttributedString(string: "Title", attributes: [.foregroundColor: UIColor.red])
    * let attrMSG = NSAttributedString(string: "Message", attributes: [.foregroundColor: UIColor.blue])
    * UIAlertController.promptAlert(attrTitle: attrTitle, attrMSG: attrMSG, ok: { _ in print("OK pressed") }, cancel: { _ in print("Cancel pressed") })
    */
   public static func promptAlert(attrTitle: NSAttributedString, attrMSG: NSAttributedString, ok: UIAlertActionHandler? = nil, cancel: UIAlertActionHandler? = nil, okTitle: String? = "OK", cancelTitle: String? = "Cancel")/* -> UIAlertController*/ {
      // Swift.print("UIAlertController.promptAlert()")
      // ⚠️️ Quick fix for bug with asyncifnot main etc, figure it out later
      DispatchQueue.main.async { // Perform the following block of code asynchronously on the main queue
         let alert = UIAlertController.createAlert(
            title: nil, // The title of the alert
            msg: nil, // The message of the alert
            ok: ok, // The handler for the OK action
            cancel: cancel, // The handler for the cancel action
            okTitle: okTitle, // The title of the OK action
            cancelTitle: cancelTitle // The title of the cancel action
         ) // Create a new alert controller with the specified title, message, actions, and titles
         // - Fixme: ⚠️️ use the built in settitle
         alert.setValue(attrTitle, forKey: "attributedTitle") // Set the attributed title of the alert controller
         alert.setValue(attrMSG, forKey: "attributedMessage") // Set the attributed message of the alert controller
         // - Fixme: ⚠️️ Use topVC code instead?
         // ⚠️️ Quick hack, issue with uialert from ios 15 etc
         // let topVC = UIApplication.rootVC?.children.last // Get the top view controller from the root view controller's children
         // - Fixme: ⚠️️ remove top-VC etc, it doesn't work so great with swiftui etc?
         // ⚠️️ The present on .mainThread maybe key to avoid crashes etc, and also Making the alert in the dispatched state
         /*topVC?.*/rootController?.presentOnMainThread(alert, animated: true) // Present the alert controller on the main thread with the specified animation and completion handler
      }
   }
}
/**
 * Setter
 */
extension UIAlertController {
   /**
    * attrMSG
    * - Description: This function sets an attributed message for the alert controller. The attributed message allows for custom styling of the message text.
    * ## Example:
    * NSAttributedString(string: "Title", attributes: [.foregroundColor: UIColor.red])
    * - Parameters:
    *   - msg: The attributed message to be set for the alert controller.
    */
   public func setAttrMSG(msg: NSAttributedString) {
      self.setValue(msg, forKey: "attributedMessage") // Set the attributed message of the alert to the specified value using key-value coding
   }
   /**
    * attrTitle
    * - Description: This function sets an attributed title for the alert controller. The attributed title allows for custom styling of the title text.
    * ## Eample:
    * NSAttributedString(string: "Message", attributes: [.foregroundColor: UIColor.blue])
    * - Parameters:
    *   - title: The attributed title to be set for the alert controller.
    */
   public func setAttrTitl(title: NSAttributedString) {
      self.setValue(title, forKey: "attributedTitle") // Set the attributed title of the alert to the specified value using key-value coding
   }
}
// preview
// - Fixme: ⚠️️ making preview for this is not simple, co-pilot cant do it
#endif
