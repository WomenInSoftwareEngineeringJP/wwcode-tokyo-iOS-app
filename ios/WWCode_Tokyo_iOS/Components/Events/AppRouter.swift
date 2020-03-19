import UIKit
class AppRouter: Router {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showEventDetail(event: Event) {
        let viewController = EventViewController(event: event)
        navigationController.pushViewController(viewController, animated: false)
    }
}
