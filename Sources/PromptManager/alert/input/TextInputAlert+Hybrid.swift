import SwiftUI
/**
 * A utility function to present a text input alert to the user, allowing for the input of text in a modal dialog with customizable placeholders, button texts, and secure text entry option.
 * - Description: This function provides a cross-platform solution to present a text input alert. It allows for the collection of user input through a modal dialog with customizable text fields, button labels, and the option for secure text entry. The function adapts to the underlying platform, presenting the appropriate style of alert for iOS or macOS.
 * - Note: we can add 1 or 2 textfields
 * - Note: set secondaryTextPlaceholder to nil to use only one textfield
 * - Example: Here's how you can present a text input alert with a single text field:
 *   ```swift
 *   showTextInputAlert(
 *       title: "Enter your name",
 *       message: "Please enter your full name below",
 *       primaryTextPlaceholder: "Full Name",
 *       onComplete: { textInputValue in
 *           if let name = textInputValue?.primary {
 *               print("Hello, \(name)!")
 *           }
 *       }
 *   )
 *   ```
 * - Parameters:
 *   - title: The title of the alert.
 *   - message: The message of the alert.
 *   - primaryTextPlaceholder: The placeholder text for the primary text field.
 *   - secondaryTextPlaceholder: The placeholder text for the secondary text field.
 *   - primaryButtonText: The text for the primary button.
 *   - secondaryButtonText: The text for the secondary button.
 *   - isSecure: A Boolean value that determines whether the text fields should hide the text being entered.
 *   - onComplete: A closure that is called when the user taps the primary button. It receives the text entered in the primary and secondary text fields.
 */
public func showTextInputAlert(title: String, message: String, primaryTextPlaceholder: String? = "", secondaryTextPlaceholder: String? = "", primaryButtonText: String = "OK", secondaryButtonText: String = "Cancel", isSecure: Bool = false, onComplete: OnTextInputComplete? = nil) {
   #if os(iOS)
   showAlertWithTextFields( // Calls the showAlertWithTextFields function to display an alert with text fields
      title: title, // Sets the title of the alert
      message: message, // Sets the message of the alert
      primaryTextPlaceholder: primaryTextPlaceholder, // Sets the placeholder text for the primary text field
      secondaryTextPlaceholder: secondaryTextPlaceholder, // Sets the placeholder text for the secondary text field
      primaryButtonText: primaryButtonText, // Sets the text for the primary button
      secondaryButtonText: secondaryButtonText, // Sets the text for the secondary button
      isSecure: isSecure, // Determines if the text fields should hide the text being entered
      onComplete: onComplete // The closure to be called when the user taps the primary button
   )
   #elseif os(macOS)
   showAlertWithTextFields( // Calls the showAlertWithTextFields function to display an alert with text fields on macOS devices
      title: title, // Sets the title of the alert
      message: message, // Sets the message of the alert
      primaryTextPlaceholder: primaryTextPlaceholder, // Sets the placeholder text for the primary text field
      secondaryTextPlaceholder: secondaryTextPlaceholder, // Sets the placeholder text for the secondary text field
      isSecure: isSecure, // Determines if the text fields should hide the text being entered
      onComplete: onComplete // The closure to be called when the user taps the primary button
   )
   #endif
}
/**
 * Attributed text input alert
 * - Description: Presents an alert with attributed text fields allowing for styled title and message content. This function supports the inclusion of one or two text fields, with customizable placeholder text, button labels, and the option for secure text entry.
 * - Note: This can be used with 2 or 1 textField input, set placeholde to nil to achive it etc
 * - Fixme: ⚠️️ move this to a scope?
 * - Parameters:
 *   - attrTitle: The attributed string for the title of the alert.
 *   - attrMSG: The attributed string for the message of the alert.
 *   - primaryTextPlaceholder: The placeholder text for the primary text field.
 *   - secondaryTextPlaceholder: The placeholder text for the secondary text field.
 *   - primaryButtonText: The text for the primary button.
 *   - secondaryButtonText: The text for the secondary button.
 *   - isSecure: A Boolean value that determines whether the text fields should hide the text being entered.
 *   - onComplete: A closure that is called when the user taps the primary button. It receives the text entered in the primary and secondary text fields.
 */
public func showTextInputAlert(attrTitle: NSAttributedString, attrMSG: NSAttributedString, primaryTextPlaceholder: String? = "", secondaryTextPlaceholder: String? = "", primaryButtonText: String = "OK", secondaryButtonText: String = "Cancel", isSecure: Bool = false, onComplete: OnTextInputComplete? = nil) {
   #if os(iOS)
   showAttributedAlertWithTextFields( // Calls the showAttributedAlertWithTextFields function to display an attributed alert with text fields
      attrTitle: attrTitle, // Sets the attributed title of the alert
      attrMSG: attrMSG, // Sets the attributed message of the alert
      primaryTextPlaceholder: primaryTextPlaceholder, // Sets the placeholder text for the primary text field
      secondaryTextPlaceholder: secondaryTextPlaceholder, // Sets the placeholder text for the secondary text field
      primaryButtonText: primaryButtonText, // Sets the text for the primary button
      secondaryButtonText: secondaryButtonText, // Sets the text for the secondary button
      isSecure: isSecure, // Determines if the text fields should hide the text being entered
      onComplete: onComplete // The closure to be called when the user taps the primary button
   )
   #elseif os(macOS)
   showAlertWithTextFields( // Calls the showAlertWithTextFields function to display an alert with text fields on macOS devices
      title: attrTitle.string, // Converts the attributed title to a plain string for macOS
      message: attrMSG.string, // Converts the attributed message to a plain string for macOS
      primaryTextPlaceholder: primaryTextPlaceholder, // Sets the placeholder text for the primary text field
      secondaryTextPlaceholder: secondaryTextPlaceholder, // Sets the placeholder text for the secondary text field
      isSecure: isSecure, // Determines if the text fields should hide the text being entered
      onComplete: onComplete // The closure to be called when the user taps the primary button
   )
   #endif
}
/**
 * Preview
 * - Description: Provides a SwiftUI preview of a text input alert with attributed title and message. This preview showcases how the alert will appear and function, including the behavior of primary and secondary text fields with placeholders, and the response upon tapping the buttons.
 * - Fixme: ⚠️️ move to own file? 👈
 */
#if os(iOS)
#Preview {
   /**
    * attrTitle is the title of the alert
    * - Description: This is an attributed string used as the title of the alert.
    */
   let attrTitle = NSAttributedString(
      string: "Title", // Sets the string for the attributed title
      attributes: [.foregroundColor: UIColor.red] // Sets the color for the attributed title
   )
   /**
    * attrMSG is the message of the alert
    * - Description: This is an attributed string used as the message of the alert.
    */
   let attrMSG = NSAttributedString(
      string: "Message", // Sets the string for the attributed message
      attributes: [.foregroundColor: UIColor.blue] // Sets the color for the attributed message
   )
   return Button("prompt") {
      showTextInputAlert( // Calls the showTextInputAlert function to display a text input alert
         attrTitle: attrTitle, // Sets the attributed title
         attrMSG: attrMSG, // Sets the attributed message
         primaryTextPlaceholder: "Enter your name", // Sets the placeholder text for the primary text field
         secondaryTextPlaceholder: "Enter your password", // Sets the placeholder text for the secondary text field
         primaryButtonText: "Submit", // Sets the text for the primary button
         secondaryButtonText: "Cancel", // Sets the text for the secondary button
         isSecure: true // Determines if the text fields should hide the text being entered
      ) { result in
         Swift.print("Name: \(result?.primary ?? ""), Password: \(result?.secondary ?? "")")
      }
   }
}
#endif
