import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(LoginPlugin)
public class LoginPlugin: CAPPlugin {
    @objc func showLogin(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        print("JS invoke Native with value = \(value)")

        let bundle = Bundle(for: Self.classForCoder())
        let storyboard = UIStoryboard(name: "Login", bundle: bundle)
        DispatchQueue.main.async {
            let controller = storyboard.instantiateViewController(withIdentifier: "CustomViewController") as? CustomViewController
            let rootNavigationController = UINavigationController(rootViewController: controller!)
            rootNavigationController.modalPresentationStyle = .fullScreen
            /// We only can delegate the full native UI Flow embed to here when plugin the same source code.
//            UIApplication.shared.windows.first!.rootViewController = UINavigationController(rootViewController: controller!)
            
//             When we using plugin as an embed full native from a repository. We can not set the root View. We only access to get propery self.bridge.viewController (can only: push, present, dismiss)
            if self.bridge == nil {
                /// Prevent crash due to unit test don't have this bridge.
                return
            }
            
            self.bridge.viewController.present(rootNavigationController, animated: true, completion: nil)
            controller?.cancelHandler = {
                self.bridge.viewController.dismiss(animated: true) {
                    call.error("User cancelled the Login Flow.")
                }
            }
            controller?.completeHandler = { token in
                self.bridge.viewController.dismiss(animated: true) {
                    call.success([
                        "JWT-TOKEN was simulated": token
                    ])
                }
            }
        }
    }
}
