import UIKit

class UpcomingEventsViewController: UIViewController {
    private var events: [Event]!
    
    init(upcomingEvents: [Event]) {
        events = upcomingEvents
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
