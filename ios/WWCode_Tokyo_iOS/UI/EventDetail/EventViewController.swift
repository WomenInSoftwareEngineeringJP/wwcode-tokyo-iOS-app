import UIKit
import PureLayout

class EventViewController: UIViewController {
    
    private var dateLabel: UILabel!
    private var timeLabel: UILabel!
    
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    private var venueName: UILabel!
    private var venueAddress: UILabel!

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
            dateLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 15.0)
            dateLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
            dateLabel.autoPinEdge(.right, to: .left, of: timeLabel)
            
            timeLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 15.0)
            timeLabel.autoPinEdge(.left, to: .right, of: dateLabel)
            timeLabel.autoPinEdge(toSuperviewSafeArea: .right, withInset: 15.0)
            
            titleLabel.autoPinEdge(.top, to: .bottom, of: dateLabel)
            titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
            titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)
            
            descriptionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
            descriptionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
            descriptionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)
            
            venueName.autoPinEdge(.top, to: .bottom, of: descriptionLabel)
            venueName.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
            venueName.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)

            venueAddress.autoPinEdge(.top, to: .bottom, of: venueName)
            venueAddress.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
            venueAddress.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func initializeViews() {
        dateLabel = UILabel.newAutoLayout()
        timeLabel = UILabel.newAutoLayout()
        titleLabel = UILabel.newAutoLayout()
        descriptionLabel = UILabel.newAutoLayout()
        venueName = UILabel.newAutoLayout()
        venueAddress = UILabel.newAutoLayout()
    }
    
    func configureNavigationBar() {
        let startDateFormatter = DateFormatter()
        startDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let startDateTime = startDateFormatter.date(from: event.startDateTime)!
        
        let dateLabelFormatter = DateFormatter()
        dateLabelFormatter.dateFormat = "MMM d, E"
        
        dateLabel.text = dateLabelFormatter.string(from: startDateTime)
        
        let endDateTime = startDateFormatter.date(from: event.endDateTime)!
        let timeLabelFormatter = DateFormatter()
        timeLabelFormatter.dateFormat = "HH:mm"
        
        timeLabel.text = "\(timeLabelFormatter.string(from: startDateTime)) - \(timeLabelFormatter.string(from: endDateTime))"
        
        titleLabel.text = event.name
        descriptionLabel.text = event.description
        
        venueName.text = event.venue.name
        venueAddress.text = "\(event.venue.address) \(event.venue.city)"
    }
    
    func addSubviews() {
        view.addSubview(dateLabel)
        view.addSubview(timeLabel)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(venueName)
        view.addSubview(venueAddress)
    }
    
    func configureSubviews() {
        view.backgroundColor = .white
    }
}
