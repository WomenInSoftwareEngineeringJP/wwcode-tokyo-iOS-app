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
    private var segmentBottomBar: UIView!
    
    init() {
        super.init(frame: CGRect.zero)
        initializeViews()
        addSubviews()
        constrainSubviews()
        configureSubviews()
        styleSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

fileprivate extension EventSegmentedControl {
    func initializeViews() {
        eventsLabel = UILabel.newAutoLayout()
        eventSegments = UISegmentedControl()
        segmentBottomBar = UIView.newAutoLayout()
    }
    
    func addSubviews() {
        addSubview(eventsLabel)
        addSubview(eventSegments)
        addSubview(segmentBottomBar)
    }
    
    func constrainSubviews() {
        eventsLabel.autoPinEdge(toSuperviewSafeArea: .top)
        eventsLabel.autoPinEdge(toSuperviewEdge: .left)
        eventsLabel.autoPinEdge(toSuperviewEdge: .right)
        
        eventSegments.autoPinEdge(.top, to: .bottom, of: eventsLabel)
        eventSegments.autoPinEdge(toSuperviewEdge: .left)
        eventSegments.autoPinEdge(toSuperviewEdge: .right)
        eventSegments.autoPinEdge(toSuperviewEdge: .bottom, withInset: 15.0)
    }
    
    func configureSubviews() {
        eventsLabel.text = "Events"
        eventsLabel.textAlignment = .center
        
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
    
    func styleSubviews() {
        backgroundColor = UIColor.wwcPrimaryColorDark
        
        eventsLabel.textColor = UIColor.wwcPrimaryColorLight
        eventsLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        eventSegments.backgroundColor = .clear
        eventSegments.selectedSegmentTintColor = .clear
        eventSegments.setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.white],
            for: UIControl.State.normal)
        eventSegments.setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)],
            for: UIControl.State.selected)
        
    }
}
