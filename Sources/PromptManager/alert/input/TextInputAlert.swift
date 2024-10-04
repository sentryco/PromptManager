import SwiftUI
/**
 * This structure represents the values entered by the user in the text fields of the alert.
 * - Fixme: ⚠️️ move into own file?
 */
public struct TextInputValue {
   /**
    * - Note: primary and secondary are the same as the textfield index
    * - Description: The text entered in the primary text field.
    */
   public let primary: String?
   /**
    * - Note: primary and secondary are the same as the textfield index
    * - Description: The text entered in the secondary text field.
    */
   public let secondary: String?
}
/**
 * On complete alias for ios and macos textfield input alert
 * fix: move to const?
 * - Description: This is a typealias for a closure that is called when the user completes input in the text fields. The closure takes an optional TextInputValue, which contains the text entered in the primary and secondary text fields.
 */
public typealias OnTextInputComplete = (TextInputValue?) -> Void
