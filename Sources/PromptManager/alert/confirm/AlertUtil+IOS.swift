import SwiftUI
#if os(iOS)
/**
 * For iOS only
 * - Description: To show an Alert in swiftui, the method of using “Alert Modifier”was common. This is an easy way to do it, but it has the problem of lengthening the code and reducing readability. The method below may not match the philosophy of SwiftUI, but it will make the code a little easier to maintain.
 * - Note: The benefit of using this over a global alert controller, is that a global alert controller needs to be attached to the app struct, Where as this is more dynamic and will work on any root controller, where ever it is, in preview it is which ever view is presented etc. makes things more easy to debug etc
 * - Note: From here: https://makestory.medium.com/how-to-present-alert-from-anywhere-in-swiftui-754a89da3321
 * - Fixme: ⚠️️ move into a proper class scope 👈 check legacy maybe? ask copilot for name suggestion of class?
 * ## Example:
 * presentAlert(title: "Save", subTitle: "Saving is required", primaryAction: .init(title: "OK", style: .default) { _ in
 *     print("Handler")
 * })
 * 
 * And
 * 
 * Button( action:{
 *    presentAlert(title: "Title", subTitle: "subTitle", primaryAction: .init(title: "Primary", style: .default, handler: {_ in
 *       print("Handler")
 *    }))
 * } ) {
 *    Text("Present Alert")
 *    }
 * 
 * And
 * 
 * Button( action:{
 *    presentAlert(title: "Title", subTitle: "subTitle", primaryAction: .init(title: "Primary", style: .default, handler: {_ in
 *       print("Handler")
 *    }),secondaryAction: .init(title: "Second", style: .cancel, handler: {_ in
 *       print("Handler2")
 *    }))
 * } ) {
 *    Text("Present Alert2")
 * }
 * - Parameters:
 *   - title: The title of the alert
 *   - subTitle: The subtitle of the alert
 *   - primaryAction: The primary action of the alert
 *   - secondaryAction: The secondary action of the alert
 */
public func presentAlert(title: String, subTitle: String, primaryAction: UIAlertAction?, secondaryAction: UIAlertAction? = nil) {
   DispatchQueue.main.async { // - Fixme: ⚠️️ maybe use async-if-main?
      // Initializes a UIAlertController with the specified title, message, and style.
      let alertController = UIAlertController(
         title: title, // The title of the alert
         message: subTitle, // The message of the alert
         preferredStyle: .alert // The style of the alert
      )
      // Adds the primary action to the alert controller if it is not nil.
      if let primary = primaryAction {
         alertController.addAction(primary)
      }
      // Adds the secondary action to the alert controller if it is not nil.
      if let secondary = secondaryAction {
         alertController.addAction(secondary)
      }
      // Presents the alert controller on the root controller, animating the presentation and without a completion handler.
      rootController?.present(
         alertController, // The alert controller to be presented
         animated: true, // A boolean indicating whether the presentation should be animated
         completion: nil // The completion handler to call after the presentation finishes
      )
   }
}
/**
 * Convenient
 * ## Examples:
 * - Fixme: ⚠️️ move into a class scope?
 * - Parameters:
 *   - title: The title of the alert
 *   - msg: The message of the alert
 *   - primaryText: The text for the primary button
 *   - secondaryText: The text for the secondary button
 *   - primaryHandler: The closure to be executed when the primary button is tapped
 *   - secondaryHandler: The closure to be executed when the secondary button is tapped
 */
public func presentAlert(title: String, msg: String, primaryText: String? = nil, secondaryText: String? = nil, primaryHandler: EmptyClosure? = nil, secondaryHandler: EmptyClosure? = nil) {
   let primaryUIAction: UIAlertAction? = {
      if let action = primaryHandler, let text = primaryText {
         .init(
            title: text, // Sets the title of the primary action
            style: .default
         ) // Sets the style of the primary action to default
            { _ in action() } // Executes the primary action handler when tapped
      } else {
         nil
      }
   }()
   let secondaryAction: UIAlertAction? = {
      if let action = secondaryHandler, let text = secondaryText {
         .init( // Initializes a UIAlertAction
            title: text, // Sets the title of the secondary action
            style: .default
         ) // Sets the style of the secondary action to default
            { _ in action() } // Executes the secondary action handler when tapped
      } else {
         nil
      }
   }()
   presentAlert( // Calls the presentAlert function to display an alert
      title: title, // The title of the alert
      subTitle: msg, // The message of the alert
      primaryAction: primaryUIAction, // The primary action to be added to the alert
      secondaryAction: secondaryAction // The secondary action to be added to the alert
   )
}
#endif
