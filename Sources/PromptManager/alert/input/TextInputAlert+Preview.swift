#if os(iOS)
import SwiftUI
/**
 * Preview for alert with textfields 
 * - Description: Provides a SwiftUI preview of an alert with text fields. This preview can be used to test and demonstrate the appearance and functionality of the alert within the SwiftUI preview environment.
 * - Important: ⚠️️ this only works for iOS
 * - Fixme: ⚠️️ add the other alerts as well 👈
 */
#Preview {
   VStack {
      Button {
         showAlertWithTextFields(
            title: "Title",
            message: "Message",
            primaryTextPlaceholder: "Primary Text",
            secondaryTextPlaceholder: "Secondary Text",
            primaryButtonText: "OK",
            secondaryButtonText: "Cancel"
         ) {
            Swift.print("$0?.primary: \(String(describing: $0?.primary))")
            Swift.print("$0?.secondary: \(String(describing: $0?.secondary))")
         }
      } label: {
         Text("Present alert")
      }
   }
   .preferredColorScheme(.dark)
}
#endif
