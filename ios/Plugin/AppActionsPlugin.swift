import Foundation
import Capacitor

@objc(AppActionsPlugin)
public class AppActionsPlugin: CAPPlugin {
    private let implementation = AppActions()

    @objc func set(_ call: CAPPluginCall) {
        if let actions = call.getArray("actions")?.capacitor.replacingNullValues() as? [String?] {
            print(actions)
        }
        
        call.resolve()
    }
}
