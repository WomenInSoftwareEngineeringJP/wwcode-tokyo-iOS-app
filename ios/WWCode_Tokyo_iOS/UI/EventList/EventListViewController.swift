import UIKit

class EventListViewController: UIViewController {
    private var events: [Event] = []
    private var eventRepository: EventRepository
    private var tableView: UITableView!
    private var didSetupConstraints: Bool = false

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
        initialzeViews()
        addSubview()
        configureSubviews()
        self.eventRepository.getEvents().onSuccess { events in
                self.events = events
                self.tableView.reloadData()
        }
    }
    
    override func updateViewConstraints() {
          if (!didSetupConstraints) {
              tableView.autoPinEdgesToSuperviewSafeArea()

              didSetupConstraints = true
          }

          super.updateViewConstraints()
      }
}

// MARK: - View Setup
fileprivate extension EventListViewController {
    func initialzeViews() {
        tableView = UITableView(frame: CGRect.zero)
    }
    
    func addSubview() {
        view.addSubview(tableView)
    }
    
    func configureSubviews() {
        tableView.backgroundColor = UIColor.lightGray
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.dataSource = self
        
        tableView.register(
                   EventTableViewCell.self,
                   forCellReuseIdentifier: String(describing: EventTableViewCell.self)
               )
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
        return 200
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventTableViewCell.self)) as? EventTableViewCell else {
            return EventTableViewCell()
        }
        
        cell.configure(event: events[indexPath.row])

        return cell
    }
}
