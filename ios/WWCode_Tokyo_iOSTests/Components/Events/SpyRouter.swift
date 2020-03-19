import UIKit

@testable import WWCode_Tokyo_iOS

class SpyRouter: Router {
    var showEventDetail_wasCalled = false
    var showEventDetail_args_event: Event?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func showEventDetail(event: Event) {
        showEventDetail_wasCalled = true
        showEventDetail_args_event = event
    }
}
