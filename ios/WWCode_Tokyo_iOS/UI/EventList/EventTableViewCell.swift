import UIKit
import PureLayout

class EventTableViewCell: UITableViewCell {
    private var containerView: UIView!
    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var timeLabel: UILabel!
    private var venueNameLabel: UILabel!

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
        containerView = UIView()
        containerView.configureForAutoLayout()
        
        dateLabel = UILabel()
        dateLabel.configureForAutoLayout()

        titleLabel = UILabel()
        titleLabel.configureForAutoLayout()
        
        timeLabel = UILabel()
        timeLabel.configureForAutoLayout()

        venueNameLabel = UILabel()
        venueNameLabel.configureForAutoLayout()
    }
    
    func addSubviews() {
        containerView.addSubview(dateLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(venueNameLabel)
        addSubview(containerView)
    }
    
    func configureSubviews() {
        containerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))

        dateLabel.autoPinEdge(.top, to: .top, of: containerView, withOffset: 20)
        dateLabel.autoPinEdge(.left, to: .left, of: containerView, withOffset: 20)
        dateLabel.autoPinEdge(.right, to: .right, of: containerView, withOffset: -20)
        
        titleLabel.autoPinEdge(.top, to: .bottom, of: dateLabel, withOffset: 10)
        titleLabel.autoPinEdge(.bottom, to: .top, of: timeLabel, withOffset: -20)
        titleLabel.autoPinEdge(.left, to: .left, of: dateLabel)
        titleLabel.autoPinEdge(.right, to: .right, of: dateLabel)

        timeLabel.autoPinEdge(.left, to: .left, of: containerView, withOffset: 20)
        timeLabel.autoPinEdge(.right, to: .right, of: containerView, withOffset: -20)
        timeLabel.autoPinEdge(.bottom, to: .top, of: venueNameLabel, withOffset: -4)

        venueNameLabel.autoPinEdge(.left, to: .left, of: containerView, withOffset: 20)
        venueNameLabel.autoPinEdge(.right, to: .right, of: containerView, withOffset: -20)
        venueNameLabel.autoPinEdge(.bottom, to: .bottom, of: containerView, withOffset: -20)
    }
    
    func styleSubviews() {
        backgroundColor = UIColor.white
        containerView.backgroundColor = UIColor.white

        containerView.layer.cornerRadius = 10.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        containerView.layer.shadowRadius = 12.0
        containerView.layer.shadowOpacity = 0.7
    }
}
