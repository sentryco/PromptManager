import SwiftUI
/**
 * Preview
 * - Description: This section of the code is used for previewing the `InputAlert` component in a SwiftUI view. It sets up a `DebugView` struct that contains a state for presenting the alert and the text input from the alert. The preview shows a gray rectangle that, when tapped, will present an `InputAlert` for text input.
 * - Note: iOS works
 * - Note: I don't think mac can show alert or sheet in preview. Run the app instead
 * - Fixme: ⚠️️ Add support for macos preview
 */
#Preview(traits: .fixedLayout(width: 400, height: 550)) {
   struct DebugView: View {
      @State var presentAlert = true
      @State var alertText: String = "1234"
      // @State private var password: String = ""
      // body
      var body: some View {
         let rect = Rectangle()
            .fill(Color.gray.opacity(0.3))
            .ignoresSafeArea()
         configInputAlert(
            view: rect,
            text: $alertText,
            title: "Enter text",
            message: "Enter the text bellow",
            isPresented: $presentAlert
         ) { (_ password: String) in
            Swift.print("ok: \(password)")
         }
      }
   }
   return DebugView()
   // .preferredColorScheme(.dark) // - Fixme: ⚠️️ try to make alert be dark in preview, do more research etc
}
