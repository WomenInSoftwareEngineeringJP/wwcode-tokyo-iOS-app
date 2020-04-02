import UIKit
import PureLayout

class EventViewController: UIViewController {
    // MARK: - Injected Properties
    private var event: Event!
    private var urlOpener: UrlOpener!
    
    // MARK: - Properties
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var didSetupConstraints = false
    
    // MARK: - View Elements
    private var dateLabel: UILabel!
    private var timeLabel: UILabel!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var venueName: UILabel!
    private var venueAddress: UILabel!
    private var registerButton: UIButton!
    
    init(event: Event, urlOpener: UrlOpener = UrlOpenerImpl()) {
        self.event = event
        self.urlOpener = urlOpener
        super.init(nibName: nil, bundle: nil)
        view.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViews()
        addSubviews()
        configureSubviews()
        styleSubviews()
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            scrollView.autoPinEdgesToSuperviewSafeArea()
            contentView.autoPinEdgesToSuperviewEdges()
            contentView.autoMatch(.width, to: .width, of: view)
            
            dateLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 20.0)
            dateLabel.autoPinEdge(.left, to: .left, of: contentView, withOffset: 20.0)
            dateLabel.autoPinEdge(.right, to: .left, of: timeLabel)

            timeLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 20.0)
            timeLabel.autoPinEdge(.left, to: .right, of: dateLabel)
            timeLabel.autoPinEdge(.right, to: .right, of: contentView, withOffset: -20.0)

            titleLabel.autoPinEdge(.top, to: .bottom, of: dateLabel, withOffset: 10.0)
            titleLabel.autoPinEdge(.left, to: .left, of: contentView, withOffset: 20.0)
            titleLabel.autoPinEdge(.right, to: .right, of: contentView, withOffset: -20.0)
            titleLabel.numberOfLines = 0
            
            descriptionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 10.0)
            descriptionLabel.autoPinEdge(.left, to: .left, of: contentView, withOffset: 20.0)
            descriptionLabel.autoPinEdge(.right, to: .right, of: contentView, withOffset: -20.0)
            descriptionLabel.numberOfLines = 0
            
            venueName.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: 10.0)
            venueName.autoPinEdge(.left, to: .left, of: contentView, withOffset: 20.0)
            venueName.autoPinEdge(.right, to: .right, of: contentView, withOffset: -20.0)
            
            venueAddress.autoPinEdge(.top, to: .bottom, of: venueName)
            venueAddress.autoPinEdge(.left, to: .left, of: contentView, withOffset: 20.0)
            venueAddress.autoPinEdge(.right, to: .right, of: contentView, withOffset: -20.0)
            
            registerButton.autoSetDimension(.height, toSize: 50)
            registerButton.autoPinEdge(.top, to: .bottom, of: venueAddress, withOffset: 20.0)
            registerButton.autoPinEdge(.left, to: .left, of: contentView, withOffset: 20.0)
            registerButton.autoPinEdge(.right, to: .right, of: contentView, withOffset: -20.0)
            registerButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 60, relation: .greaterThanOrEqual)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
}

// MARK: - View Setup
fileprivate extension EventViewController {
    func initializeViews() {
        scrollView = UIScrollView.newAutoLayout()
        contentView = UIView.newAutoLayout()
        
        dateLabel = UILabel.newAutoLayout()
        timeLabel = UILabel.newAutoLayout()
        titleLabel = UILabel.newAutoLayout()
        descriptionLabel = UILabel.newAutoLayout()
        venueName = UILabel.newAutoLayout()
        venueAddress = UILabel.newAutoLayout()
        registerButton = UIButton.newAutoLayout()
    }
    
    func addSubviews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(venueName)
        contentView.addSubview(venueAddress)
        contentView.addSubview(registerButton)
        
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
    
    func configureSubviews() {
        configureDateAndTime()
        configureTitleAndDescription()
        configureVenue()
        configureRegistration()
    }
    
    func styleSubviews() {
        view.backgroundColor = .white
        contentView.backgroundColor = .white
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor(red:0.24, green:0.25, blue:0.26, alpha:1.00)
        dateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        dateLabel.textColor = UIColor(red:0.20, green:0.47, blue:0.48, alpha:1.00)
        timeLabel.textColor = UIColor(red:0.24, green:0.25, blue:0.26, alpha:1.00)
    }
    
    func configureDateAndTime() {
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
    }
    
    func configureTitleAndDescription() {
        titleLabel.text = event.name
        
        do {
            let data = event.description.data(using: .utf8)!
            let description = try NSAttributedString(
                    data: data,
                    options: [
                        .documentType: NSAttributedString.DocumentType.html,
                        .characterEncoding: String.Encoding.utf8.rawValue
                    ],
                    documentAttributes: nil)
            
            descriptionLabel.attributedText = description
        } catch {
            // noop
        }
    }
    
    func configureVenue() {
        venueName.text = event.venue.name
        venueAddress.text = "\(event.venue.address) \(event.venue.city)"
    }
    
    func configureRegistration() {
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = UIColor.registerButtonNormal
        registerButton.layer.cornerRadius = 4
        registerButton.addTarget(self, action: #selector(registerButtonWasTapped), for: .touchUpInside)
    }
    
    @objc func registerButtonWasTapped() {
        urlOpener.openUrl(url: event.link)
    }
}
