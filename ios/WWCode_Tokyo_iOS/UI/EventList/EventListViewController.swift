import UIKit

class EventListViewController: UIViewController {
    private struct i18n {
        static let UpcomingTitle: String = NSLocalizedString("UPCOMING_EVENTS_TITLE", comment: "Section Title")
        static let PastTitle: String = NSLocalizedString("PAST_EVENTS_TITLE", comment: "Section Title")
    }
    
    // MARK: - Injected Properties
    private var router: Router
    private var eventRepository: EventRepository
    private var reloader: Reloader

    // MARK: - Properties
    private var didSetupConstraints: Bool = false
    private var events: [Event] = []
    
    // MARK: - View Elements
    private var eventsLabel: UILabel!
    private var eventSegments: UISegmentedControl!
    private(set) var tableView: UITableView!

    init(router: Router, eventRepository: EventRepository, reloader: Reloader) {
        self.eventRepository = eventRepository
        self.router = router
        self.reloader = reloader
        super.init(nibName: nil, bundle: nil)
        
        view.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViews()
        addSubview()
        configureSubviews()
        
        eventRepository.getUpcomingEvents().onSuccess { upcomingEvents in
            self.events = upcomingEvents
            self.reloader.reload(reloadable: self.tableView)
        }
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            eventsLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 15.0)
            eventsLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
            eventsLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)
            
            eventSegments.autoPinEdge(.top, to: .bottom, of: eventsLabel)
            
            tableView.autoPinEdge(.top, to: .bottom, of: eventSegments)
            tableView.autoPinEdge(toSuperviewEdge: .left)
            tableView.autoPinEdge(toSuperviewEdge: .right)
            tableView.autoPinEdge(toSuperviewEdge: .bottom)

            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
}

// MARK: - View Setup
fileprivate extension EventListViewController {
    func initializeViews() {
        eventsLabel = UILabel.newAutoLayout()
        eventSegments = UISegmentedControl()
        tableView = UITableView(frame: CGRect.zero)
    }
    
    func addSubview() {
        view.addSubview(eventsLabel)
        view.addSubview(eventSegments)
        view.addSubview(tableView)
    }
    
    func configureSubviews() {
        self.view.backgroundColor = .white
        
        eventsLabel.text = "Events"
        
        eventSegments.insertSegment(
            withTitle: i18n.UpcomingTitle,
            at: 0,
            animated: false
        )
        eventSegments.insertSegment(
            withTitle: i18n.PastTitle,
            at: 1,
            animated: false
        )
        eventSegments.selectedSegmentIndex = 0
        eventSegments.addTarget(
            self,
            action: #selector(didSelectEventSegment),
            for: .valueChanged
        )
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            EventTableViewCell.self,
            forCellReuseIdentifier: String(describing: EventTableViewCell.self)
        )
    }
}

fileprivate extension EventListViewController {
    @objc func didSelectEventSegment(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex)
        
        if (selectedTitle == i18n.UpcomingTitle) {
            eventRepository.getUpcomingEvents().onSuccess { upcomingEvents in
                self.events = upcomingEvents
                self.reloader.reload(reloadable: self.tableView)
            }
        } else {
            eventRepository.getPastEvents().onSuccess { pastEvents in
                self.events = pastEvents
                self.reloader.reload(reloadable: self.tableView)
            }
        }
    }
}

// MARK: - Table view data source
extension EventListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 234
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventTableViewCell.self)) as? EventTableViewCell else {
            return EventTableViewCell()
        }

        let event = events[indexPath.row]
        cell.configure(event: event)

        return cell
    }
}

// MARK: - Table view delegate
extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]

        router.showEventDetail(event: event)
    }
}
