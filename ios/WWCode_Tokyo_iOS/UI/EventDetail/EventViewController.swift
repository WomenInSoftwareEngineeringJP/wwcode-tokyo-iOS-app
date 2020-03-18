import UIKit
import PureLayout

class EventViewController: UIViewController {
    
    private var titleLabel: UILabel!
    private var didSetupConstraints = false
    private var event: Event!
    
    init(event: Event) {
        super.init(nibName: nil, bundle: nil)
        self.event = event
        view.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViews()
        configureNavigationBar()
        addSubviews()
        configureSubviews()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            titleLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 15.0)
            titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
            titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)

            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func initializeViews() {
        titleLabel = UILabel.newAutoLayout()
    }
    
    func configureNavigationBar() {
        titleLabel.text = event.name
    }
    
    func addSubviews() {
        view.addSubview(titleLabel)
    }
    
    func configureSubviews() {
        view.backgroundColor = .white
    }
}
