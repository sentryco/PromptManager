import SwiftUI
/**
 * - Description: This section of the code is used for previewing the `SheetState` component in a SwiftUI view. It sets up a `DebugView` struct that contains a state for presenting the alert. The preview shows two buttons that, when tapped, will present an alert for the corresponding action.
 * - Important: ⚠️️ ActionSheet is de-precated, lib wont compile if you try to use it etc
 * - Fixme: ⚠️️ Add sheet example as well? 👈
 */
#Preview {
   class AlertPrompt: SheetState<AlertPrompt.Category> {
      // Defines an enumeration for the categories of actions that can be taken
      enum Category: String { case save, cancel }
   }
   struct DebugView: View {
      @StateObject var alert = AlertPrompt()
      var body: some View {
         VStack(spacing: 24) { // Vertical stack with spacing between elements
            Button("Save") { alert.state = .save } // Button to set alert state to save
            Button("Cancel") { alert.state = .cancel } // Button to set alert state to cancel
         }
         // .actionSheet(isPresented: $alert.isShowing, content: {
         //    ActionSheet(title: Text(alert.state?.rawValue ?? "None"), buttons: [
         //       Alert.Button.default(Text("OK"), action: {})
         //    ])
         // })
         .alert(alert.state?.rawValue ?? "None", // Displays an alert with the raw value of the alert state or "None" if nil
                isPresented: $alert.isShowing) // Presents a single action button labeled "ok" with no action // Binds the alert's isShowing state to the presentation state
                { Button("ok") {} }
      }
   }
   return DebugView()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.black)
      .environment(\.colorScheme, .dark) // dark / light
}
//   {
//   { // - Fixme: ⚠️️ re-name to isPresenting
//      didSet {
//         Swift.print("didSet isShowing: \(isShowing)")
//
//         guard isShowing == false else { return } // avoids not triggering bool
//         state = nil // reset
//      }
//   }
//         guard state != nil else { return }
//         isShowing = true // trigger bool binding
//         Swift.print("didSet state: \(String(describing: state))")
