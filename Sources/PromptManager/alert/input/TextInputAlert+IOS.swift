import SwiftUI
#if os(iOS)
/**
 * This function shows an alert with one or two text fields
 * - Description: This function displays an alert with one or two text fields, allowing the user to input text. The alert can be customized with placeholders, button texts, and secure text entry options. When the user taps a button, a closure is called with the entered text.
 * - Fixme: ⚠️️ add support for initText? 👉 textField.text
 * - Fixme: ⚠️️ add to a class scope? ask copilot for file name suggestion
 * - Parameters:
 *    - title: The title of the alert.
 *    - message: The message of the alert.
 *    - primaryTextPlaceholder: The placeholder for the first text field.
 *    - secondaryTextPlaceholder: The placeholder for the second text field.
 *    - primaryButtonText: The text for the primary button.
 *    - secondaryButtonText: The text for the secondary button.
 *    - onComplete: A closure that is called when the primary or secondary button is tapped. The closure takes an optional tuple of two strings. If the primary button is tapped, the tuple contains the text from the two text fields. If the secondary button is tapped, the tuple is nil.
 */
public func showAlertWithTextFields(title: String, message: String, primaryTextPlaceholder: String? = "", secondaryTextPlaceholder: String? = "", primaryButtonText: String = "OK", secondaryButtonText: String = "Cancel", isSecure: Bool = false, onComplete: OnTextInputComplete? = nil) {
   var alertController = UIAlertController( // Initializes a UIAlertController
      title: title, // Sets the title of the alert
      message: message, // Sets the message of the alert
      preferredStyle: .alert // Sets the style of the alert to alert
   )
   alertController = configAlert( // Calls the configAlert function to configure the alert controller
      alertController: alertController, // Passes the UIAlertController instance to be configured
      primaryTextPlaceholder: primaryTextPlaceholder, // Sets the placeholder text for the primary text field
      secondaryTextPlaceholder: secondaryTextPlaceholder, // Sets the placeholder text for the secondary text field
      primaryButtonText: primaryButtonText, // Sets the text for the primary button
      secondaryButtonText: secondaryButtonText, // Sets the text for the secondary button
      isSecure: isSecure, // Determines if the text fields should hide the text being entered
      onComplete: onComplete // The closure to be called when the primary button is tapped
   )
   // Present the alert controller
   rootController?.present( // Presents the UIAlertController instance on the root view controller
      alertController, // Passes the UIAlertController instance to be presented
      animated: true, // Determines if the presentation should be animated
      completion: nil // The closure to be called when the presentation is complete
   )
}
/**
 * Show attributed alert with one or two textfields
 * - Description: This function displays an alert with one or two text fields, allowing the user to input text. The alert can be customized with placeholders, button texts, and secure text entry options. When the user taps a button, a closure is called with the entered text.
 * - Note: To use only one textfield explicitly set secondaryText...placholder to nil
 * - Important: ⚠️️ The attributed string must be correct or it will crash the app
 * - Parameters:
 *   - attrTitle: The attributed title of the alert.
 *   - attrMSG: The attributed message of the alert.
 *   - primaryTextPlaceholder: The placeholder text for the primary text field.
 *   - secondaryTextPlaceholder: The placeholder text for the secondary text field.
 *   - primaryButtonText: The text for the primary button.
 *   - secondaryButtonText: The text for the secondary button.
 *   - isSecure: A Boolean value that determines whether the text fields should hide the text being entered.
 *   - onComplete: A closure that is called when the user taps the primary button. It receives the text entered in the primary and secondary text fields.
 */
public func showAttributedAlertWithTextFields(attrTitle: NSAttributedString, attrMSG: NSAttributedString, primaryTextPlaceholder: String? = "", secondaryTextPlaceholder: String? = "", primaryButtonText: String = "OK", secondaryButtonText: String = "Cancel", isSecure: Bool = false, onComplete: OnTextInputComplete? = nil) {
   DispatchQueue.asyncIfNotMain { // ⚠️️ Attempt at fixing
      var alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
      alert.setAttrTitl(title: attrTitle) // Sets the attributed title of the alert to the specified title
      alert.setAttrMSG(msg: attrMSG) // Sets the attributed message of the alert to the specified message
      alert = configAlert( // Calls the configAlert function to configure the alert controller
         alertController: alert, // Passes the alert controller to be configured
         primaryTextPlaceholder: primaryTextPlaceholder, // Sets the placeholder text for the primary text field
         secondaryTextPlaceholder: secondaryTextPlaceholder, // Sets the placeholder text for the secondary text field
         primaryButtonText: primaryButtonText, // Sets the text for the primary button
         secondaryButtonText: secondaryButtonText, // Sets the text for the secondary button
         isSecure: isSecure, // Determines if the text fields should hide the text being entered
         onComplete: onComplete // The closure to be called when the primary button is tapped
      )
      // Present the alert controller
      // ⚠️️ Using presentOnMain may avoid crash
      rootController?.presentOnMainThread( // Presents the UIAlertController instance on the main thread
         alert, // The alert controller to be presented
         animated: true // Determines if the presentation should be animated
      ) // .present(alertController, animated: true, completion: nil)
   }
}
/**
 * Config alert
 * - Description: Configures the UIAlertController by adding text fields and actions based on the provided parameters. This function allows for the creation of a customizable alert dialog with optional primary and secondary text input fields, and executes a completion handler with the input values upon tapping the primary button.
 * - Note: Used by `showAlertWithTextFields` and `showAttributedAlertWithTextFields`
 * - Fixme: ⚠️️ Move to a class scope etc?
 * - Parameters:
 *   - alertController: The UIAlertController instance to be configured. 
 *   - primaryTextPlaceholder: The placeholder text for the primary text field.  
 *   - secondaryTextPlaceholder: The placeholder text for the secondary text field.  
 *   - primaryButtonText: The text for the primary button.  
 *   - secondaryButtonText: The text for the secondary button.  
 *   - isSecure: A Boolean indicating if the text fields should hide the text being entered.  
 *   - onComplete: The closure to be called when the primary button is tapped. 
 * - Returns: The configured UIAlertController instance. 
 */
fileprivate func configAlert(alertController: UIAlertController, primaryTextPlaceholder: String? = "", secondaryTextPlaceholder: String? = "", primaryButtonText: String = "OK", secondaryButtonText: String = "Cancel", isSecure: Bool = false, primaryInputTextFieldID: String = "primaryInputTextField", secondaryInputTextFieldID: String = "secondaryInputTextField", onComplete: OnTextInputComplete? = nil) -> UIAlertController {
   // First input-text-field
   if let primaryTextPlaceholder = primaryTextPlaceholder {
      alertController.addTextField { textField in // Adds a text field to the alert controller
         textField.placeholder = primaryTextPlaceholder // Sets the placeholder text for the text field
         textField.isSecureTextEntry = isSecure // Determines if the text field should hide the text being entered
         textField.accessibilityIdentifier = primaryInputTextFieldID // Sets the accessibility identifier for the text field
      }
   }
   // Second intput-text-field
   if let secondaryTextPlaceholder = secondaryTextPlaceholder {
      alertController.addTextField { textField in // Adds a text field to the alert controller for secondary input
         textField.placeholder = secondaryTextPlaceholder // Sets the placeholder text for the secondary text field
         textField.isSecureTextEntry = isSecure // Determines if the secondary text field should hide the text being entered
         textField.accessibilityIdentifier = secondaryInputTextFieldID // Sets the accessibility identifier for the secondary text field
      }
   }
   // Add actions
   let primaryAction = UIAlertAction(title: primaryButtonText, style: .default) { [weak alertController] _ in
      guard let alertController = alertController else { // Checks if the alert controller is not nil
         onComplete?(nil) // Calls the onComplete closure with nil if the alert controller is nil
         return // Returns from the closure if the alert controller is nil
      }
      let primaryText = alertController.textFields?.first?.text // Gets the text entered in the primary text field
      let secondaryText = alertController.textFields?.last?.text // Gets the text entered in the secondary text field
      onComplete?(
         .init(
            primary: primaryText, // Sets the primary text value
            secondary: secondaryText // Sets the secondary text value
         )
      )
   }
   // Initializes an UIAlertAction for the secondary button with a cancel style and a handler that calls the onComplete closure with nil when tapped
   let secondaryAction = UIAlertAction(
      title: secondaryButtonText, // Sets the title of the secondary button
      style: .cancel // Sets the style of the secondary button to cancel
   ) { _ in
      // Calls the onComplete closure with nil when the secondary button is tapped
      onComplete?(nil)
   }
   // Adds the primary action to the alert controller
   alertController.addAction(primaryAction)
   // Adds the secondary action to the alert controller
   alertController.addAction(secondaryAction)
   return alertController
}
#endif
