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
        // retainUntilConsumed keeps the event until a JS listener subscribes.
        // This handles the cold-launch case where the app is started *by* a
        // quick action and the action is delivered before the web layer has
        // had a chance to register its listeners.
        //
        // NOTE: the data must be non-nil. Capacitor stores retained events in
        // an array, and passing `nil` with retainUntilConsumed crashes with
        // "insert nil into array". Sending the actionId is both safe and useful.
        self.notifyListeners(actionId, data: ["actionId": actionId], retainUntilConsumed: true)
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
