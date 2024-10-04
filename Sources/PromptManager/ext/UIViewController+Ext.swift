#if os(iOS)
import UIKit
/**
 * Parser
 */
extension UIViewController {
   /**
    * Type alias for a closure that takes no parameters and returns void.
    */
   internal typealias OnComplete = () -> Void
   /**
    * Presents a view controller on the main thread with optional animation and completion handler.
    * - Description: This method ensures that the view controller presentation occurs on the main thread, which is necessary for UI updates. Presenting on a background thread can lead to unpredictable behavior and crashes. The method uses asynchronous dispatch to the main queue to present the view controller, optionally with animation, and executes a completion handler if provided.
    * - Note: Present on main thread
    * - Fixme: ⚠️️ remove ..thread? maybe not?
    * - Parameters:
    *   - vc: The view controller to present.
    *   - animated: A boolean indicating whether to use animation.
    *   - completion: A closure to execute when the transition is complete.
    */
   internal func presentOnMainThread(_ vc: UIViewController, animated: Bool, completion: OnComplete? = nil) {
      DispatchQueue.main.async { [weak self] in // weakify - Execute the following code on the main thread, and weakify self to avoid retain cycles
         self?.present(vc, animated: animated, completion: completion) // Present the specified view controller modally on self with the specified animation and completion handler
      }
   }
}
#endif
