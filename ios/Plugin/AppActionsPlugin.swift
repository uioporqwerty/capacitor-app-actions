import Foundation
import Capacitor

@objc(AppActionsPlugin)
public class AppActionsPlugin: CAPPlugin {
    private let implementation = AppActions()
    
    @objc override public func load() {
        NotificationCenter.default.addObserver(self, selector: #selector(onAction), name: Notification.Name("appActionReceived"), object: nil)
    }
    
    @objc func onAction(notification: NSNotification) {
        let actionId = notification.userInfo?["actionId"] as! String
        self.notifyListeners(actionId, data: nil)
    }
    
    @objc func set(_ call: CAPPluginCall) {
        if #available(iOS 13, *) {            
            //TODO: Improve based on this: https://capacitorjs.com/docs/core-apis/data-types#arrays
            if let actions = call.getArray("actions", AnyObject.self) {
                var shortcutItems: [UIApplicationShortcutItem] = []
                var shortcutItemIds: [String] = []
                for action in actions {
                    let actionId = action["id"]! as! String
                    shortcutItemIds.append(actionId)
                    
                    var icon: UIApplicationShortcutIcon?
                    if action["icon"] != nil {
                        icon = UIApplicationShortcutIcon(systemImageName: action["icon"] as! String)
                    }
                    
                    let shortcutItem = UIApplicationShortcutItem(type: actionId,
                                                                 localizedTitle: action["title"]! as! String,
                                                                 localizedSubtitle: action["subtitle"] as? String,
                                                                 icon: icon)
                    
                    shortcutItems.append(shortcutItem)
                }
                
                DispatchQueue.main.async {
                    UIApplication.shared.shortcutItems = shortcutItems
                }
            }
            call.resolve()
        }
        else {
            call.unavailable("App actions are only available on iOS 13 or higher.")
        }
    }
}
