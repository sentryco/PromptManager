import Foundation
/**
 * For attributed alert
 */
public struct TitleAndClosure {
   /**
    * The title to be associated with the closure.
    * - Description: The text that will be displayed as the title in the alert dialog.
    */
   public let title: String
   /**
    * The closure to be executed.
    * - Description: The closure that will be executed when the associated action is triggered.
    */
   public let closure: () -> Void
   /**
    * Initializes a TitleAndClosure instance with a title and a closure.
    * - Description: This initializer creates a `TitleAndClosure` instance which pairs a given title with an executable closure. This can be used to represent an action and its textual representation within an alert dialog.
    * - Parameters:
    *   - title: The title to be associated with the closure.
    *   - closure: The closure to be executed.
    */
   public init(title: String, closure: @escaping () -> Void) {
      self.title = title
      self.closure = closure
   }
}
