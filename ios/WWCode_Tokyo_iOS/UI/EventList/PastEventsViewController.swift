import UIKit

class PastEventsViewController: UIViewController {
    private var events: [Event]!
    
    init(pastEvents: [Event]) {
        events = pastEvents
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
