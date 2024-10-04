import SwiftUI
/**
 * Groups sheet and alert states into an `ObservableObject`
 * - Description: The `<State>` part of `SheetState` is defining a generic type. It doesn’t know, or care, what’s going to be passed to it. It just knows it can be an optional. This is defined in the subclass
 * - Important: ⚠️️ If there is an environment "dismiss" method in preview, then it auto dismisses for some strange random reason.
 * - Important: ⚠️️ Make sure there is atleast one @StateObject that has this as a reference, @ObservableObject's can be "bindings" in subviews etc
 * - Note: Ref: https://masilotti.com/multiple-sheets-swiftui/
 * - Note: Alternative name: `PromptState` 👈 we use this for sheet and alert
 * - Note: This is used in the UI prompt system for managing the state of sheets and alerts.
 * - Fixme: ⚠️️ figure out the side-effects of ObservableObject etc, do some testing and research, ask copilot maybe?
 * - Fixme: ⚠️️ I think maybe we can do the item instead of bool now for alert, then all this is not needed etc?
 */
open class SheetState<State>: ObservableObject {
   /**
    * Needed to be able to override and init the class etc, has no functionality
    * - Fixme: ⚠️️ remove this init? I think its needed right? or?
    */
   public init() {}
   /**
    * Boolean binding
    * - Description: This is a boolean binding that indicates whether the sheet is currently being displayed or not.
    * - Note: We don't set this, we set the state, and state sets the bool binding
    * - Fixme: ⚠️️ maybe set default value in init or just keep it here?
    * - Important: ⚠️️ this can't be private as we set it in alert isPresented
    */
   @Published public var isShowing: Bool = false
   /**
    * Set this and the boolean updates
    * - Important: ⚠️️ There is a bug the state. it may fires twice if we also diff on the state when deciding to use fullscreen or half screen etc. Willset doesnt work. but wrapping it in dispatch queue main async works. without causing other issues etc
    */
   @Published public var state: State? {
      didSet { // called after
         // ⚠️️ Needed to avoid double reactive calls for some edge cases etc
         DispatchQueue.main.async {
            self.isShowing = self.state != nil
         }
      }
   }
}
