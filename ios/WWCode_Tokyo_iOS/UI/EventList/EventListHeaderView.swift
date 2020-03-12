import PureLayout
import UIKit

class EventListHeaderView: UIView {
    private var headerTitle: UILabel!
    
    init() {
        super.init(frame: CGRect.zero)
        initializeViews()
        addSubviews()
        constrainSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        headerTitle.text = title
    }
}

fileprivate extension EventListHeaderView {
    func initializeViews() {
        headerTitle = UILabel.newAutoLayout()
    }
    
    func addSubviews() {
        addSubview(headerTitle)
    }
    
    func constrainSubviews() {
        headerTitle.autoPinEdgesToSuperviewEdges()
    }
}
