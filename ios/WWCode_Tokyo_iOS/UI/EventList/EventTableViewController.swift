import UIKit

class EventTableViewController: UITableViewController {
    private var events: [Event]?
    private var eventRepository: EventRepository?
    
    init(eventRepository: EventRepository? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        self.eventRepository = eventRepository
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        events = eventRepository?.getEvents()
    }
}

// MARK: - Table view data source
extension EventTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : EventTableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "event") as? EventTableViewCell

        if cell == nil {
            cell = EventTableViewCell(style: .default, reuseIdentifier: "event")
        }
        
        if let events = events {
            cell.configure(event: events[indexPath.row])
        }

        return cell
    }
}
