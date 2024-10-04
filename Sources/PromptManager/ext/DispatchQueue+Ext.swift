import Foundation
/**
 * DispatchQueue extension
 */
extension DispatchQueue {
   /**
    * - Description: Executes a closure on the main thread if the current thread is not the main thread. 
    *                It ensures that UI updates or other main thread-only operations are performed safely from a background thread.
    * - Remark: Allows less threading code in the main code
    * - Note: Suprisingly it also allows return
    * - Example: `DispatchQueue.asyncIfNotMain { print("This is executed on the main thread") }`
    * - Fixme: ⚠️️ Could we use this way of doing things in a semphore wrapper?
    * - Fixme: ⚠️️ I think maybe this doesn't work anymore. Could be the return stuff etc? revert to old code?
    * - Parameter closure: closure that will execute on main
    * - Returns: result of closure
    */
   internal static func asyncIfNotMain<T>(_ closure: @escaping () -> T) -> T {
      var retVal: T? // Declare a variable named "retVal" of type T and initialize it to nil
      if !Thread.isMainThread { // Check if the current thread is not the main thread
         DispatchQueue.main.async { retVal = closure() } // Execute the closure on the main thread and assign the result to "retVal"
      }
      return retVal ?? closure() // Return "retVal" if it is not nil, or execute the closure and return its result if "retVal" is nil
   }
}
