import SwiftUI
/**
 * - Note: Alternative name: `DetailAlertModel`
 * - Description: This struct is used to create a custom alert in SwiftUI. It takes a title, a message, a primary button text, and an optional action closure as parameters. The action closure is called when the primary button is tapped.
 * - Fixme: ⚠️️ We could make this an enum, with none case and rebind the `isPresenting`, there is code that does that in this project etc, wait until we settle the alert and sheet code, there are some issues etc
 * - Fixme: ⚠️️ We could maybe make a protocol, and store model in custom structs? or no?
 */
public struct AlertModel {
   /**
    * The title of the alert.
    * - Description: This is the title of the alert. It is a brief summary of the alert's content.
    */
   let title: String
   /**
    * The message of the alert.
    * - Description: The detailed explanation of the alert's content.
    */
   let message: String
   /**
    * The text of the primary button.
    * - Description: The text that will be displayed on the primary button of the alert.
    */
   let primary: String
   /**
    * The action to perform when the primary button is tapped.
    * - Description: This closure is executed when the primary button of the alert is pressed. It can be used to perform any necessary tasks in response to the user's interaction with the alert.
    */
   let action: EmptyClosure?
   /**
    * - Parameters:
    *   - title: Alert title
    *   - message: Alert message
    *   - primary: Button text
    *   - action:  Button action
    */
   public init(title: String, message: String, primary: String, action: EmptyClosure?) {
      self.title = title
      self.message = message
      self.primary = primary
      self.action = action
   }
}
/**
 * Universal prompt call that can us `action-sheet` or `alert-based` (hybrid call, iOs and macOS)
 * - Important: ⚠️️ ActionSheet doesn't look good on iPad and macOS, so we use alert normal instead
 * - Fixme: ⚠️️⚠️️ We can use `actionSheet<T>(item: Binding<T?>` instead of bool binding 🏀 (see alert blog article)  we should do like we did with item. where we can show different configurations. see mainview alert system etc
 * - Fixme: ⚠️️ Add support for cancel-btn text and action
 * - Fixme: ⚠️️⚠️️⚠️️ Seems apple are deprecating actionSheet and favour `confirmationSheet` do some research on this etc
 * - Fixme: ⚠️️ move this into a scope and make a new file
 * - Fixme: ⚠️️ break up the method int two? 👈
 * - Fixme: ⚠️️ why is alert model optional? Check availability in the caller instead?
 * - Parameters:
 *   - view: View to prompt alert from
 *   - alertModel: Title, msg, action
 *   - isPresenting: Trigger binding
 * - Returns: The modified view with the alert or action sheet configured and presented based on the device type and alert model provided.
 */
@ViewBuilder
public func promptPopup(view: some View, alertModel: AlertModel?, isPresenting: Binding<Bool>) -> some View {
   // let _ = { Swift.print("promptActionSheet() - alertModel.title: \(String(describing: alertModel?.title))") }
   if let alertModel: AlertModel = alertModel { // ⚠️️ We can't use guard, because viewbuilder etc
      if isPhoneDevice {
         // let _ = { Swift.print("promptActionSheet() - phone alert") }() // ⚠️️ debug
         #if os(iOS) // Needed because some of the code bellow is not available for macOS
         view.actionSheet(isPresented: isPresenting) {
            ActionSheet(
               title: Text(alertModel.title), // Sets the title of the action sheet
               message: Text(alertModel.message), // Sets the message of the action sheet
               buttons: [
                  .destructive(Text(alertModel.primary)) { // Defines a destructive button with the primary action
                     alertModel.action?() // Executes the action associated with the alert model
                  },
                  .cancel() // We don't need to do anthing when we press cancel
               ])
         }
         #endif
      } else { // For iPad / macOS
         // let _ = { Swift.print("promptActionSheet() - desktop alert") }() // ⚠️️ debug
         view.alert(isPresented: isPresenting) {
            Alert(
               title: Text(alertModel.title), // Sets the title of the alert
               message: Text(alertModel.message), // Sets the message of the alert
               primaryButton: .destructive(Text(alertModel.primary)) { Swift.print("primary action()"); alertModel.action?() }, // Defines a destructive primary button with the primary action
               secondaryButton: .cancel() // Defines a cancel button
            ) // We don't need to do anthing when we press cancel
         }
      }
   } else {
//      let _ = { Swift.print("⚠️️ no alertModel: \(alertModel)") }() // ⚠️️ debug
      view // Just return view, - Fixme: ⚠️️ why? skip this since its viewbuilder?
   }
}
