import PureLayout
import UIKit

class EventListHeaderView: UIView {
    private var upcomingLabel: UILabel!
    
    init() {
        super.init(frame: CGRect.zero)
        initializeViews()
        addSubviews()
        constrainSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeViews() {
        upcomingLabel = UILabel.newAutoLayout()
        upcomingLabel.text = "Upcoming"
    }
    
    func constrainSubviews() {
        upcomingLabel.autoPinEdgesToSuperviewEdges()
    }
    
    func addSubviews() {
        addSubview(upcomingLabel)
    }
}
