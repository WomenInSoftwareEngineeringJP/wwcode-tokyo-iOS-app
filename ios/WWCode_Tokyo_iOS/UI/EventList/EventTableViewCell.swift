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
        titleLabel.text = event.name
        dateLabel.text = event.date
        timeLabel.text = event.time
        venueNameLabel.text = event.venueName
    }
       
}

fileprivate extension EventTableViewCell {
    
    func initializeViews() {
        containerView = UIView()
        containerView.configureForAutoLayout()
        
        titleLabel = UILabel()
        titleLabel.configureForAutoLayout()
        
        dateLabel = UILabel()
        dateLabel.configureForAutoLayout()
        
        timeLabel = UILabel()
        timeLabel.configureForAutoLayout()
        
        venueNameLabel = UILabel()
        venueNameLabel.configureForAutoLayout()
    }
    
    func addSubviews() {
        containerView.addSubview(titleLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(venueNameLabel)
        addSubview(containerView)
    }
    
    func configureSubviews() {
        containerView.autoPinEdge(.top, to: .top, of: contentView, withOffset: 80)
        containerView.autoPinEdge(.left, to: .left, of: contentView, withOffset: 20)
        containerView.autoPinEdge(.right, to: .right, of: contentView, withOffset: -20)
        containerView.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -20)
                
        dateLabel.autoPinEdge(.top, to: .top, of: containerView, withOffset: 20)
        dateLabel.autoPinEdge(.left, to: .left, of: containerView, withOffset: 20)
        dateLabel.autoPinEdge(.right, to: .right, of: containerView, withOffset: -20)
        
        titleLabel.autoPinEdge(.top, to: .bottom, of: dateLabel, withOffset: 4)
        titleLabel.autoPinEdge(.left, to: .left, of: containerView, withOffset: 20)
        titleLabel.autoPinEdge(.right, to: .right, of: containerView, withOffset: -20)

        timeLabel.autoPinEdge(.left, to: .left, of: containerView, withOffset: 20)
        timeLabel.autoPinEdge(.right, to: .right, of: containerView, withOffset: -20)
        timeLabel.autoPinEdge(.bottom, to: .top, of: venueNameLabel, withOffset: 4)
        
        venueNameLabel.autoPinEdge(.bottom, to: .bottom, of: containerView, withOffset: -20)
        venueNameLabel.autoPinEdge(.left, to: .left, of: containerView, withOffset: 20)
        venueNameLabel.autoPinEdge(.right, to: .right, of: containerView, withOffset: -20)
    }
    
    func styleSubviews() {
        backgroundColor = UIColor.lightGray

        containerView.layer.cornerRadius = 10.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        containerView.layer.shadowRadius = 12.0
        containerView.layer.shadowOpacity = 0.7
        
        // todo:
        let myFont = UIFont.init(name: "Noto Sans JP", size: 20)
        titleLabel.font = myFont
    }
}
