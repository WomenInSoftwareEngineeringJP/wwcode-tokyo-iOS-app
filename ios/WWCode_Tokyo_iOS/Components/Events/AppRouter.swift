import UIKit
class AppRouter: Router {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        styleNavigationBar()
    }

    func showEventDetail(event: Event) {
        let viewController = EventViewController(event: event)
        navigationController.pushViewController(viewController, animated: false)
    }

    private func styleNavigationBar() {
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = UIColor.wwcPrimaryColorDark
    }
}
