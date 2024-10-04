import SwiftUI
/**
 * Previews normal alert and attributed alert
 * - Important: ⚠️️ Prompting an alert for macOS doesn't work in preview, use iOS
 */
#Preview(traits: .fixedLayout(width: 400, height: 550)) {
   VStack(spacing: 24) {
      Button {
         // Calls the promptAlert function to display an alert with a title, message, and two buttons
         promptAlert(
            title: "Title", // Sets the title of the alert
            msg: "subTitle", // Sets the message of the alert
            primaryText: "OK", // Sets the text for the primary button
            secondaryText: "Cancel", // Sets the text for the secondary button
            primaryHandler: { print("on ok") }, // Executes when the primary button is tapped
            secondaryHandler: { print("on cancel") } // Executes when the secondary button is tapped
         )
      } label: {
         // Displays a button with the label "Prompt alert"
         Text("Prompt alert")
      }
      Button {
         // Creates an attributed string for the title with red color
         let attrTitle = NSAttributedString(
            string: "Title", // Sets the string value of the attributed string to "Title"
            attributes: [.foregroundColor: Color.red] // Sets the foreground color of the attributed string to red
         )
         // Creates an attributed string for the message with blue color
         let attrMSG = NSAttributedString(
            string: "Message", // Sets the string value of the attributed string to "Message"
            attributes: [.foregroundColor: Color.blue] // Sets the foreground color of the attributed string to blue
         )
         // Calls the promptAlert function to display an attributed alert with a title, message, and two buttons
         promptAlert(
            attrTitle: attrTitle, // Sets the attributed title for the alert
            attrMSG: attrMSG, // Sets the attributed message for the alert
            primary: .init(title: "OK", closure: { print("pressed ok") }), // Sets the primary button with title "OK" and its action
            secondary: .init(title: "cancel", closure: { print("Cancel pressed") }) // Sets the secondary button with title "cancel" and its action
         )
      } label: {
         Text("Present attributed alert") // Displays a button with the label "Present attributed alert"
      }
      #if os(iOS)
      Button("Present alert") { // ⚠️️ not sure what the diff is between this and promptAlert
         presentAlert(
            title: "Alert Title", // Sets the title of the alert
            msg: "This is an alert message", // Sets the message of the alert
            primaryText: "OK", // Sets the text for the primary button
            secondaryText: "Cancel", // Sets the text for the secondary button
            primaryHandler: {
               print("OK button tapped") // Executes when the primary button is tapped
            },
            secondaryHandler: {
               print("Cancel button tapped") // Executes when the secondary button is tapped
            }
         )
      }
      #endif
   }
   .frame(width: 400, height: 550)
   .preferredColorScheme(.dark)
}
