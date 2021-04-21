
import UIKit

final class Router {
    static func showRoot(window: UIWindow) {
        let storyboardName = "Main"
        let vc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController() as! ViewController
        let navVC = UINavigationController(rootViewController: vc)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
}
