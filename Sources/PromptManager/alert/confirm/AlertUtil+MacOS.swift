import SwiftUI
/**
 * Define a function that takes a message, a title for the alert, and two closures
 * - Description: The first closure is called if the user clicks the first button, and the second closure is called for the second button.
 * - Important: ⚠️️ This works but wont be testable in Preview. Yu have to run the app etc
 * - Important: ⚠️️ A better approch is to use .alert and debug in iOS, it will work for macOS as well, so debug in iOS and use UITests for macOS to make sure it runs there etc
 * - Fixme: ⚠️️ move into a proper class scope, ask copilot for name etc
 * ## Examples:
 * showAlert(message: "Do you want to proceed?", title: "Confirmation") {
 *    print("First button clicked")
 * } button2Handler: {
 *    print("Second button clicked")
 * }
 * - Parameters:
 *   - title: The title of the alert.
 *   - message: The message to be displayed in the alert.
 *   - primaryButtonText: The text for the primary button.
 *   - secondaryButtonText: The text for the secondary button.
 *   - button1Handler: The closure to be executed when the primary button is clicked.
 *   - button2Handler: The closure to be executed when the secondary button is clicked.
 */
#if os(macOS)
public func showAlert(title: String, message: String, primaryButtonText: String?, secondaryButtonText: String?, button1Handler: (() -> Void)?, button2Handler: (() -> Void)?) {
   let alert = NSAlert() // Initializes an NSAlert instance
   alert.messageText = title  // Sets the title of the alert
   alert.informativeText = message // if let message = message {  }
   if let primaryButtonText = primaryButtonText {
      alert.addButton(withTitle: primaryButtonText) // Adds a button to the alert with the specified primary button text
   }
   if let secondaryButtonText = secondaryButtonText {
      alert.addButton(withTitle: secondaryButtonText) // Adds a button to the alert with the specified secondary button text
   }
   // Present the alert
   let response = alert.runModal()
   // Check which button was clicked and call the corresponding closure
   if response == NSApplication.ModalResponse.alertFirstButtonReturn {
      // Executes the closure associated with the primary button if it is not nil
      button1Handler?()
   } else if response == NSApplication.ModalResponse.alertSecondButtonReturn {
      // Executes the closure associated with the secondary button if it is not nil
      button2Handler?()
   }
}
#endif
