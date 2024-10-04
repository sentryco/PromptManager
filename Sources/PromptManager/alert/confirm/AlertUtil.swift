import SwiftUI
/**
 * Prompt alert (iOS and macOS)
 * - Description: This function displays a customizable alert with optional primary and secondary buttons. Each button can execute a closure when tapped, allowing for specific actions to be taken in response to user interaction.
 * - Fixme: ⚠️️⚠️️ Move into a proper class scope 👈 what should the name of the class be called? ask copilot for suggestions?
 * - Fixme: ⚠️️ Rename file to `ConfirmAlert` or keep as is?
 * ## Examples:
 * - Parameters:
 *   - title: The title of the alert
 *   - msg: The message of the alert
 *   - primaryText: The text for the primary button
 *   - secondaryText: The text for the secondary button
 *   - primaryHandler: The closure to be executed when the primary button is tapped
 *   - secondaryHandler: The closure to be executed when the secondary button is tapped
 */
public func promptAlert(title: String, msg: String, primaryText: String? = nil, secondaryText: String? = nil, primaryHandler: (() -> Void)? = nil, secondaryHandler: (() -> Void)? = nil) {
   #if os(iOS)
   presentAlert( // Calls the presentAlert function to display an alert on iOS devices
      title: title, // Sets the title of the alert
      msg: msg, // Sets the message of the alert
      primaryText: primaryText, // Sets the text for the primary button
      secondaryText: secondaryText, // Sets the text for the secondary button
      primaryHandler: primaryHandler, // Sets the handler for the primary button
      secondaryHandler: secondaryHandler // Sets the handler for the secondary button
   )
   #elseif os(macOS)
   showAlert( // Calls the showAlert function to display an alert on macOS devices
      title: title, // Sets the title of the alert
      message: msg, // Sets the message of the alert
      primaryButtonText: primaryText, // Sets the text for the primary button
      secondaryButtonText: secondaryText, // Sets the text for the secondary button
      button1Handler: primaryHandler, // Sets the handler for the primary button
      button2Handler: secondaryHandler // Sets the handler for the secondary button
   )
   #endif
}
/**
 * Prompt attributed alert for (iOS and macOS)
 * - Description: This function displays an alert with customizable attributed text for the title and message, and optional primary and secondary buttons. Each button is associated with a `TitleAndClosure` instance, which includes a title for the button and a closure to execute when the button is tapped.
 * - Fixme: ⚠️️ Potentially make msg optional?
 * - Fixme: ⚠️️ Add support for style: `.destructive`, // The style of the OK action
 * - Fixme: ⚠️️ Move to some scope, maybe `UIAlertController` ext? do this when we begin cleaning up and consolodating Alert and sheet code etc
 * - Parameters:
 *   - attrTitle: The attributed string for the title of the alert.
 *   - attrMSG: The attributed string for the message of the alert.
 *   - primary: The text for the primary button.
 *   - secondary: The text for the secondary button.
 */
public func promptAlert(attrTitle: NSAttributedString, attrMSG: NSAttributedString, primary: TitleAndClosure? = nil, secondary: TitleAndClosure? = nil) {
   #if os(iOS)
   // let attrTitle = NSAttributedString(string: "Title", attributes: [.foregroundColor: UIColor.red])
   // let attrMSG = NSAttributedString(string: "Message", attributes: [.foregroundColor: UIColor.blue])
   UIAlertController.promptAlert( // Calls the promptAlert function of UIAlertController
      attrTitle: attrTitle, // Sets the attributed title of the alert
      attrMSG: attrMSG, // Sets the attributed message of the alert
      ok: { _ in primary?.closure() }, // Executes the primary button's closure when tapped
      cancel: { _ in secondary?.closure() }, // Executes the secondary button's closure when tapped
      okTitle: primary?.title, // Sets the title of the primary button
      cancelTitle: secondary?.title // Sets the title of the secondary button
   )
   #elseif os(macOS)
   promptAlert( // Calls the promptAlert function to display an alert on macOS devices
      title: attrTitle.string, // Converts the attributed title to a plain string for macOS
      msg: attrMSG.string, // Converts the attributed message to a plain string for macOS
      primaryText: primary?.title, // Sets the primary button text from the primary TitleAndClosure instance
      secondaryText: secondary?.title, // Sets the secondary button text from the secondary TitleAndClosure instance
      primaryHandler: primary?.closure, // Sets the primary button handler from the primary TitleAndClosure instance
      secondaryHandler: secondary?.closure // Sets the secondary button handler from the secondary TitleAndClosure instance
   )
   #endif
}
