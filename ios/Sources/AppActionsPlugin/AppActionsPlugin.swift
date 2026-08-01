import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(AppActionsPlugin)
public class AppActionsPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "AppActionsPlugin"
    public let jsName = "AppActions"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "set", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = AppActions()

    @objc override public func load() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onAction),
            name: Notification.Name("appActionReceived"),
            object: nil
        )
    }

    @objc func onAction(notification: NSNotification) {
        guard let actionId = notification.userInfo?["actionId"] as? String else {
            return
        }
        self.notifyListeners(actionId, data: nil)
    }

    @objc func set(_ call: CAPPluginCall) {
        guard let actions = call.getArray("actions", JSObject.self) else {
            call.reject("The \"actions\" option is required and must be an array.")
            return
        }

        var shortcutItems: [UIApplicationShortcutItem] = []
        for action in actions {
            guard let actionId = action["id"] as? String,
                  let title = action["title"] as? String else {
                call.reject("Each app action requires an \"id\" and a \"title\".")
                return
            }

            var icon: UIApplicationShortcutIcon?
            if let iconName = action["icon"] as? String {
                icon = UIApplicationShortcutIcon(systemImageName: iconName)
            }

            let shortcutItem = UIApplicationShortcutItem(
                type: actionId,
                localizedTitle: title,
                localizedSubtitle: action["subtitle"] as? String,
                icon: icon
            )

            shortcutItems.append(shortcutItem)
        }

        DispatchQueue.main.async {
            UIApplication.shared.shortcutItems = shortcutItems
        }

        call.resolve()
    }
}
