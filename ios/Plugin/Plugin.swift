import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(LoginPlugin)
public class LoginPlugin: CAPPlugin {
    @objc func showLogin(_ call: CAPPluginCall) {
        print("Javascript -> invoke Native API")
        
        let value = call.getString("value") ?? ""
        let bundle = Bundle(for: Self.classForCoder())
        let storyboard = UIStoryboard(name: "Login", bundle: bundle)
        print(storyboard)
        DispatchQueue.main.async {
            let controller = storyboard.instantiateViewController(withIdentifier: "CustomViewController") as? CustomViewController
            let rootNavigationController = UINavigationController(rootViewController: controller!)
            /// We only can delegate the full native UI Flow embed to here when plugin the same source code.
//            UIApplication.shared.windows.first!.rootViewController = UINavigationController(rootViewController: controller!)
            
//             When we using plugin as an embed full native from a repository. We can not set the root View. We only access to get propery self.bridge.viewController (can only: push, present, dismiss)
            self.bridge.viewController.present(rootNavigationController, animated: true, completion: nil)
            controller?.cancelHandler = {
                self.bridge.viewController.dismiss(animated: true) {
                    call.success([
                        "value": value
                    ])
                }
            }
            
        }
    }
}
