import UIKit

class EventListViewController: UIViewController {
    // MARK: - Injected Properties
    private var router: Router
    private var eventRepository: EventRepository
    private var reloader: Reloader

    // MARK: - Properties
    private var didSetupConstraints: Bool = false
    private var events: [Event] = []
    
    // MARK: - View Elements
    private var eventSegmentsTab: EventSegmentedControl!
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
            eventSegmentsTab.autoPinEdge(toSuperviewSafeArea: .top)
            eventSegmentsTab.autoPinEdge(toSuperviewEdge: .left)
            eventSegmentsTab.autoPinEdge(toSuperviewEdge: .right)
            let navigationBarHeight = self.router.navigationController.navigationBar.frame.height
            eventSegmentsTab.autoSetDimension(.height, toSize: 160 - navigationBarHeight)
            
            tableView.autoPinEdge(.top, to: .bottom, of: eventSegmentsTab)
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
        eventSegmentsTab = EventSegmentedControl()
        tableView = UITableView(frame: CGRect.zero)
    }
    
    func addSubview() {
        view.addSubview(eventSegmentsTab)
        view.addSubview(tableView)
    }
    
    func configureSubviews() {
        self.view.backgroundColor = .white
        
        eventSegmentsTab.eventSegments.addTarget(
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
        
        if (selectedTitle == EventSegments.upcoming.sectionTitle) {
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
