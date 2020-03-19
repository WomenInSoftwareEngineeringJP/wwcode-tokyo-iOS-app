import UIKit

protocol Router {
    var navigationController: UINavigationController { get }
    
    func showEventDetail(event: Event)
}
