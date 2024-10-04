import SwiftUI
/**
 * Config input alert
 * - Description: A configurable alert view with an input field for SwiftUI. It can be used to gather text input from the user, with support for secure text entry.
 * - Note: We can use this for backup opening maybe, or should that also be apart of the view flow?
 * - Important: This is swiftUI, and requires a view and binding to work
 * - Fixme: ⚠️️ make the default text as consts 👈 
 * - Fixme: ⚠️️ make this psw view: https://stackoverflow.com/a/74401753/5389500
 * - Fixme: ⚠️️ we can use this for when we re-name a device etc?
 * - Fixme: ⚠️️⚠️️ make this as a version where it takes two fields that must match etc, see legacy code for logic etc
 * - Fixme: ⚠️️ move to own scope etc 👈 which one? InputAlert? or Alert or? ask copilot?
 * Configures and displays an alert with a single text input field.
 * - Parameters:
 *   - view: The view that will present the alert.
 *   - text: The initial text to display in the text field. (binding)
 *   - title: The title of the alert.
 *   - message: The message to display in the alert.
 *   - okString: The text for the OK button.
 *   - cancelString: The text for the Cancel button.
 *   - placeHolderText: The placeholder text for the text field.
 *   - isSecure: Determines if the text field should be secure (e.g., for passwords).
 *   - isPresented: A binding that controls the presentation of the alert.
 *   - onOK: A closure called when the OK button is tapped, passing the text entered.
 * - Returns: The view with the alert configured.
 */
public func configInputAlert(view: some View, text: Binding<String>, title: String, message: String, okString: String = "OK", cancelString: String = "Cancel", placeHolderText: String = "", isSecure: Bool = false, isPresented: Binding<Bool>, onOK: ((_ password: String) -> Void)?) -> some View {
   view.alert(
      title, // Sets the title of the alert
      isPresented: isPresented, // Binds the presentation state of the alert
      actions: { // Defines the actions for the alert
      if isSecure { // Secure textfield
         SecureField(
            placeHolderText, // Sets the placeholder text for the text field
            text: text // Binds the text to the state variable
         )
      } else { // not secure textfield
         TextField(
            placeHolderText, // Sets the placeholder text for the text field
            text: text // Binds the text to the state variable
         )
         // .focused($focused, equals: .unSecure)
         #if os(iOS)
         .autocapitalization(.none) // Sets the autocapitalization type to none
         #endif
         .disableAutocorrection(true) // Disables autocorrection
         // .keyboardType(.numberPad) // Sets the keyboard type to number pad
      }
      Button(okString, role: .destructive) { // Defines the OK button
         Swift.print("InputAlert - text:  \(text.wrappedValue)")
         onOK?(text.wrappedValue) // Calls the onOK closure with the text entered
      }
      Button(cancelString, role: .cancel) { // Defines the Cancel button
         // Swift.print("cancel - don't do anything") 
      }
      }, message: { // Defines the message for the alert
      Text(message) // Displays the message in the alert
      })
}
