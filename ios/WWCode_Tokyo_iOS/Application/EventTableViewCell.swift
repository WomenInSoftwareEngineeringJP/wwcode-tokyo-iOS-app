import UIKit
import PureLayout

class EventTableViewCell: UITableViewCell {
    
    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var timeLabel: UILabel!
    private var venueNameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeViews()
        addSubviews()
        configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeViews() {
        titleLabel = UILabel()
        titleLabel.configureForAutoLayout()
        
        dateLabel = UILabel()
        dateLabel.configureForAutoLayout()
        
        timeLabel = UILabel()
        timeLabel.configureForAutoLayout()
        
        venueNameLabel = UILabel()
        venueNameLabel.configureForAutoLayout()
    }
    
    func configure(event: Event) {
        titleLabel.text = event.name
        dateLabel.text = event.date
        timeLabel.text = event.time
        venueNameLabel.text = event.venueName
    }
    
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(timeLabel)
        addSubview(venueNameLabel)
    }
    
    func configureSubviews() {
        dateLabel.autoPinEdge(.top, to: .top, of: contentView)
        dateLabel.autoPinEdge(.left, to: .left, of: contentView)
        
        titleLabel.autoPinEdge(.top, to: .bottom, of: dateLabel)
        titleLabel.autoPinEdge(.left, to: .left, of: contentView)
        
        timeLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
        timeLabel.autoPinEdge(.left, to: .left, of: contentView)
        
        venueNameLabel.autoPinEdge(.top, to: .bottom, of: timeLabel)
        venueNameLabel.autoPinEdge(.left, to: .left, of: contentView)
    }
}
