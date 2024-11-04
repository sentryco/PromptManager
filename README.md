[![Tests](https://github.com/sentryco/PromptManager/actions/workflows/Tests.yml/badge.svg)](https://github.com/sentryco/PromptManager/actions/workflows/Tests.yml)
[![codebeat badge](https://codebeat.co/badges/60b7748c-3675-4f19-b779-c2a675aed3c1)](https://codebeat.co/projects/github-com-sentryco-promptmanager-main)

# PromptManager

> Alert and sheet tools for macOS and iOS

PromptManager is a versatile library designed to simplify the creation and management of alerts and sheets on macOS and iOS platforms. It provides a robust set of tools to handle various dialog types with ease, ensuring a consistent and user-friendly interface across different Apple devices.

## Features

- **Cross-Platform Support**: Works seamlessly on both macOS (v14 and above) and iOS (v17 and above).
- **SwiftUI Ready**: Fully compatible with SwiftUI, offering a modern way to manage UI components.
- **Extensible**: Easily extendable to include more complex alert types or custom interactions.

## Presenting a Simple Alert

This example demonstrates how to present a simple alert with primary and secondary actions on both iOS and macOS platforms.

```swift
promptAlert(
    title: "Save Changes?",
    msg: "Do you want to save the changes you made?",
    primaryText: "Save",
    secondaryText: "Cancel",
    primaryHandler: { print("Changes saved") },
    secondaryHandler: { print("Cancelled") }
)
```

### Presenting an Alert with Text Input

This example shows how to present an alert that includes text input fields, suitable for scenarios like login forms.

```swift
showTextInputAlert(
    title: "Login",
    message: "Please enter your username and password",
    primaryTextPlaceholder: "Username",
    secondaryTextPlaceholder: "Password",
    primaryButtonText: "Login",
    secondaryButtonText: "Cancel",
    isSecure: true,
    onComplete: { credentials in
        if let username = credentials?.primary, let password = credentials?.secondary {
            print("Username: \(username), Password: \(password)")
        } else {
            print("User cancelled login")
        }
    }
)
```

### Presenting an Attributed Alert

This example demonstrates how to present an alert with attributed text, which allows for more stylized text presentations.

```swift
let attrTitle = NSAttributedString(string: "Important Update", attributes: [.foregroundColor: UIColor.red])
let attrMSG = NSAttributedString(string: "Please read the terms and conditions carefully.", attributes: [.foregroundColor: UIColor.blue])
UIAlertController.promptAlert(
    attrTitle: attrTitle,
    attrMSG: attrMSG,
    ok: { print("Accepted") },
    cancel: { print("Declined") },
    okTitle: "Accept",
    cancelTitle: "Decline"
)
```

## Swift Package Manager

```swift
.package(url: "https://github.com/sentryco/PromptManager", branch: "main")
```

## License

PromptManager is available under the MIT license. See the LICENSE file for more info.
