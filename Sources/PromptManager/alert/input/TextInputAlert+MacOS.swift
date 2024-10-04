import SwiftUI
#if os(macOS)
import AppKit
/**
 * This function shows an alert with two text fields.
 * - Description: This function presents a modal alert with customizable text fields, allowing the user to input text. The alert includes a title, message, and customizable button labels. It supports the option to make text fields secure for password entry. Upon dismissal, a closure is executed with the inputted text as a tuple or nil if cancelled.
 * - Fixme: ⚠️️ add support for init text 👉 secondaryTextField.stringValue
 * - Fixme: ⚠️️ use .with {} on some of the code bellow
 * - Fixme: ⚠️️ add to a class scope?
 * - Fixme: ⚠️️ move some of the values to consts etc?
 * - Fixme: ⚠️️ add code from legacy
 * - Parameters:
 *    - title: The title of the alert.
 *    - message: The message of the alert.
 *    - primaryTextPlaceholder: The placeholder for the first text field.
 *    - secondaryTextPlaceholder: The placeholder for the second text field.
 *    - primaryButtonText: The text for the primary button.
 *    - secondaryButtonText: The text for the secondary button.
 *    - onComplete: A closure that is called when the primary or secondary button is tapped. The closure takes an optional tuple of two strings. If the primary button is tapped, the tuple contains the text from the two text fields. If the secondary button is tapped, the tuple is nil.
 * - Example:
 *   ```swift
 *   showAlertWithTextFields(
 *       title: "Login",
 *       message: "Please enter your username and password",
 *       primaryTextPlaceholder: "Username",
 *       secondaryTextPlaceholder: "Password",
 *       primaryButtonText: "Login",
 *       secondaryButtonText: "Cancel"
 *   ) { result in
 *       if let (username, password) = result {
 *           Swift.print("Username: \(username), Password: \(password)")
 *       } else {
 *           Swift.print("User cancelled login")
 *       }
 *   }
 *   ```
 */
public func showAlertWithTextFields(title: String, message: String, primaryTextPlaceholder: String? = "", secondaryTextPlaceholder: String? = "", primaryButtonText: String = "OK", secondaryButtonText: String = "Cancel", isSecure: Bool = false, primaryInputTextFieldID: String = "primaryInputTextField", secondaryInputTextFieldID: String = "secondaryInputTextField", onComplete: OnTextInputComplete? = nil) {
   let alert = NSAlert()  // Initializes an NSAlert instance
   alert.messageText = title  // Sets the title of the alert
   alert.informativeText = message  // Sets the message of the alert
   alert.addButton(withTitle: primaryButtonText)  // Adds a button to the alert with the specified primary button text
   alert.addButton(withTitle: secondaryButtonText)  // Adds a button to the alert with the specified secondary button text
   // Create stack
   let stack = NSStackView()  // Initializes an NSStackView instance
   stack.orientation = .vertical  // Sets the orientation of the stack to vertical
   stack.alignment = .leading  // Sets the alignment of the stack to leading
   stack.distribution = .fillEqually  // Sets the distribution of the stack to fill equally
   stack.spacing = 12  // Sets the spacing between the views in the stack
   // Primary textfield (input)
   let primaryTextField: NSTextField? = {
      guard let primaryTextPlaceholder: String = primaryTextPlaceholder else { return nil }
      let primaryTextField = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))  // Initializes an NSTextField instance with a frame of 200x24 pixels
      primaryTextField.placeholderString = primaryTextPlaceholder
      primaryTextField.setAccessibilityIdentifier(primaryInputTextFieldID) // Sets the accessibility identifier of the primary text field
      return primaryTextField
   }()
   if let primaryTextField = primaryTextField {
      stack.addArrangedSubview(primaryTextField)  // Adds the primary text field to the stack
   }
   // Secondary textfield (input)
   let secondaryTextField: NSTextField? = {
      guard let secondaryTextPlaceholder: String = secondaryTextPlaceholder else { return nil }
      let secondaryTextField = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))  // Initializes an NSTextField instance with a frame of 200x24 pixels
      secondaryTextField.placeholderString = secondaryTextPlaceholder  // Sets the placeholder string of the secondary text field
      secondaryTextField.setAccessibilityIdentifier(secondaryInputTextFieldID)  // Sets the accessibility identifier of the secondary text field
      return secondaryTextField
   }()
   if let secondaryTextField = secondaryTextField {
      stack.addArrangedSubview(secondaryTextField)
   }
   // - Fixme: ⚠️️ look at legacy code for better implementation
   // ⚠️️ quick hack
   let height: CGFloat = {
      if secondaryTextField != nil, primaryTextField != nil {
         return 24 + 12 + 24  // Adds 12 pixels of spacing between the two text fields
      } else if secondaryTextField != nil || primaryTextField != nil {
         return 24  // Returns 24 if either text field is not nil
      } else {
         fatalError("⚠️️ not supported")
      }
   }()
   stack.frame = NSRect(x: 0, y: 0, width: 200, height: height)  // Sets the frame of the stack to a rectangle with a width of 200 pixels and a height of the calculated height
   // stack.fixedSize() // ⚠️️ new
   // add stack to alert view
   alert.accessoryView = stack
   // handle response
   let response = alert.runModal()
   if response == .alertFirstButtonReturn {
      onComplete?(.init(primary: primaryTextField?.stringValue, secondary: secondaryTextField?.stringValue))
   } else {
      onComplete?(nil)
   }
}
#endif
/*views: [primaryTextField, secondaryTextField].compactMap { $0 }*/
