import UIKit
import PureLayout

class EventTableViewCell: UITableViewCell {
    private var cardView: UIView!
    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var timeLabel: UILabel!
    private var venueNameLabel: UILabel!
    private var clockIcon: UIImageView!
    private var mappinIcon: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeViews()
        addSubviews()
        configureSubviews()
        styleSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(event: Event) {
        let startDateFormatter = DateFormatter()
        startDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let startDateTime = startDateFormatter.date(from: event.startDateTime)!
        
        let dateLabelFormatter = DateFormatter()
        dateLabelFormatter.dateFormat = "MMM d, E"
        
        dateLabel.text = dateLabelFormatter.string(from: startDateTime)
        titleLabel.text = event.name
        
        let endDateTime = startDateFormatter.date(from: event.endDateTime)!
        let timeLabelFormatter = DateFormatter()
        timeLabelFormatter.dateFormat = "HH:mm"
        
        timeLabel.text = "\(timeLabelFormatter.string(from: startDateTime)) - \(timeLabelFormatter.string(from: endDateTime))"
        
        venueNameLabel.text = event.venue.name
    }
}

fileprivate extension EventTableViewCell {
    
    func initializeViews() {
        cardView = UIView()
        cardView.configureForAutoLayout()
        
        dateLabel = UILabel()
        dateLabel.configureForAutoLayout()

        titleLabel = UILabel()
        titleLabel.configureForAutoLayout()
        
        timeLabel = UILabel()
        timeLabel.configureForAutoLayout()

        venueNameLabel = UILabel()
        venueNameLabel.configureForAutoLayout()
        
        clockIcon = UIImageView(image: UIImage(named: "clock"))
        clockIcon.configureForAutoLayout()
        
        mappinIcon = UIImageView(image: UIImage(named: "mappin.circle"))
        mappinIcon.configureForAutoLayout()
    }
    
    func addSubviews() {
        cardView.addSubview(dateLabel)
        cardView.addSubview(titleLabel)
        cardView.addSubview(clockIcon)
        cardView.addSubview(timeLabel)
        cardView.addSubview(mappinIcon)
        cardView.addSubview(venueNameLabel)
        addSubview(cardView)
    }
    
    func configureSubviews() {
        cardView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))

        dateLabel.autoPinEdge(.top, to: .top, of: cardView, withOffset: 30)
        dateLabel.autoPinEdge(.left, to: .left, of: cardView, withOffset: 20)
        dateLabel.autoPinEdge(.right, to: .right, of: cardView, withOffset: -20)

        titleLabel.autoPinEdge(.top, to: .bottom, of: dateLabel, withOffset: 10)
        titleLabel.autoPinEdge(.left, to: .left, of: dateLabel)
        titleLabel.autoPinEdge(.right, to: .right, of: dateLabel)
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor(red:0.24, green:0.25, blue:0.26, alpha:1.00)

        clockIcon.autoPinEdge(.left, to: .left, of: cardView, withOffset: 20)
        clockIcon.autoPinEdge(.bottom, to: .top, of: venueNameLabel, withOffset: -4)
        clockIcon.autoSetDimensions(to: CGSize(width: 18, height: 18))
        timeLabel.autoPinEdge(.left, to: .right, of: clockIcon, withOffset: 4)
        timeLabel.autoPinEdge(.right, to: .right, of: cardView, withOffset: -20)
        timeLabel.autoPinEdge(.bottom, to: .top, of: venueNameLabel, withOffset: -4)

        mappinIcon.autoPinEdge(.left, to: .left, of: cardView, withOffset: 20)
        mappinIcon.autoPinEdge(.bottom, to: .bottom, of: cardView, withOffset: -20)
        mappinIcon.autoSetDimensions(to: CGSize(width: 18, height: 18))
        venueNameLabel.autoPinEdge(.left, to: .right, of: mappinIcon, withOffset: 4)
        venueNameLabel.autoPinEdge(.right, to: .right, of: cardView, withOffset: -20)
        venueNameLabel.autoPinEdge(.bottom, to: .bottom, of: cardView, withOffset: -20)
    }
    
    func styleSubviews() {
        backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        cardView.backgroundColor = UIColor.white

        cardView.layer.cornerRadius = 4
        cardView.layer.shadowColor = UIColor.darkGray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cardView.layer.shadowRadius = 2.0
        cardView.layer.shadowOpacity = 0.3
        
        dateLabel.textColor = UIColor(red:0.20, green:0.47, blue:0.48, alpha:1.00)
        
        clockIcon.tintColor = UIColor(red:0.74, green:0.75, blue:0.76, alpha:1.00)
        timeLabel.textColor = UIColor(red:0.24, green:0.25, blue:0.26, alpha:1.00)
        
        mappinIcon.tintColor = UIColor(red:0.74, green:0.75, blue:0.76, alpha:1.00)
        venueNameLabel.textColor = UIColor(red:0.24, green:0.25, blue:0.26, alpha:1.00)
    }
}
