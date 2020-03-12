import UIKit

class EventListViewController: UIViewController {
    private var upcomingEvents: [Event] = []
    private var pastEvents: [Event] = []
    private var eventRepository: EventRepository
    private var tableView: UITableView!
    private var didSetupConstraints: Bool = false

    private var eventsLabel: UILabel!
    private var upcomingLabel: UILabel!
    private var pastLabel: UILabel!

    init(eventRepository: EventRepository) {
        self.eventRepository = eventRepository
    
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
        eventRepository.getUpcomingEvents().onSuccess { events in
                self.upcomingEvents = events
                self.tableView.reloadData()
        }
        eventRepository.getPastEvents().onSuccess { events in
                self.pastEvents = events
                self.tableView.reloadData()
        }
    }
    
    override func updateViewConstraints() {
          if (!didSetupConstraints) {
              eventsLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 15.0)
              eventsLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
              eventsLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)
              
              upcomingLabel.autoPinEdge(.top, to: .bottom, of: eventsLabel)
              upcomingLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
              upcomingLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)

            //              tableView.autoPinEdgesToSuperviewSafeArea()
            
            
            tableView.autoPinEdge(.top, to: .bottom, of: upcomingLabel)
            tableView.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
            tableView.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)
            tableView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 15.0)
            
              didSetupConstraints = true
          }

          super.updateViewConstraints()
      }
}

// MARK: - View Setup
fileprivate extension EventListViewController {
    func initializeViews() {
        tableView = UITableView(frame: CGRect.zero)
        eventsLabel = UILabel.newAutoLayout()
        upcomingLabel = UILabel.newAutoLayout()
    }
    
    func addSubview() {
        view.addSubview(tableView)
        view.addSubview(eventsLabel)
        view.addSubview(upcomingLabel)
    }
    
    func configureSubviews() {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.dataSource = self
        tableView.register(
                   EventTableViewCell.self,
                   forCellReuseIdentifier: String(describing: EventTableViewCell.self)
               )

        eventsLabel.text = "Events"
        upcomingLabel.text = "Upcoming"
        
        self.view.backgroundColor = .white
    }
}

// MARK: - Table view data source
extension EventListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingEvents.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventTableViewCell.self)) as? EventTableViewCell else {
            return EventTableViewCell()
        }
        
        cell.configure(event: upcomingEvents[indexPath.row])

        return cell
    }
}
