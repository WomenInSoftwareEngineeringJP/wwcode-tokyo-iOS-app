import UIKit
import PureLayout

enum EventSegments {
    case upcoming
    case past
    
    var sectionTitle: String {
        get {
            switch self {
            case .upcoming: return NSLocalizedString("UPCOMING_EVENTS_TITLE", comment: "Section Title")
            case .past: return NSLocalizedString("PAST_EVENTS_TITLE", comment: "Section Title")
            }
        }
    }
}

class EventSegmentedControl: UIView {
    private var eventsLabel: UILabel!
    var eventSegments: UISegmentedControl!
    
    init() {
        super.init(frame: CGRect.zero)
        initializeViews()
        addSubviews()
        constrainSubviews()
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

fileprivate extension EventSegmentedControl {
    func initializeViews() {
        eventsLabel = UILabel.newAutoLayout()
        eventSegments = UISegmentedControl()
    }
    
    func addSubviews() {
        addSubview(eventsLabel)
        addSubview(eventSegments)
    }
    
    func constrainSubviews() {
        eventsLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 15.0)
        eventsLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
        eventsLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)
        
        eventSegments.autoPinEdge(.top, to: .bottom, of: eventsLabel)
        eventSegments.autoPinEdge(toSuperviewEdge: .left)
        eventSegments.autoPinEdge(toSuperviewEdge: .right)
        eventSegments.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    func configureSubviews() {
        eventsLabel.text = "Events"
        
        eventSegments.insertSegment(
            withTitle: EventSegments.upcoming.sectionTitle,
            at: 0,
            animated: false
        )
        eventSegments.insertSegment(
            withTitle: EventSegments.past.sectionTitle,
            at: 1,
            animated: false
        )
        eventSegments.selectedSegmentIndex = 0
    }
}
