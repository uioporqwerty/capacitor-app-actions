import Foundation
import Capacitor

public struct AppAction {
    let id: String
    let title: String
}

@objc(AppActionsPlugin)
public class AppActionsPlugin: CAPPlugin {
    private let implementation = AppActions()

    @objc func set(_ call: CAPPluginCall) {
        //TODO: Improve based on this: https://capacitorjs.com/docs/core-apis/data-types#arrays
        if let actions = call.getArray("actions", AnyObject.self) {
            var shortcutItems: [UIApplicationShortcutItem] = []
            for action in actions {
                var icon: UIApplicationShortcutIcon?
                if action["icon"] != nil {
                    icon = UIApplicationShortcutIcon(systemImageName: action["icon"] as! String)
                }
                
                let shortcutItem = UIApplicationShortcutItem(type: action["id"]! as! String, localizedTitle: action["title"]! as! String, localizedSubtitle: action["subtitle"] as? String, icon: icon)
                
                shortcutItems.append(shortcutItem)
            }
            
            DispatchQueue.main.async {
                UIApplication.shared.shortcutItems = shortcutItems
            }
        }
        
        call.resolve()
    }
}
