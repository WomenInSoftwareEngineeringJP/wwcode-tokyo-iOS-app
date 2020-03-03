import UIKit

class EventTableViewController: UITableViewController {
    private var events: [Event]!
    
    init(fakeRepo: FakeEventRepo) {
        super.init(nibName: nil, bundle: nil)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        events = fakeRepo.getEvents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell : EventTableViewCell!
         cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as? EventTableViewCell
         if cell == nil {
             cell = EventTableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
         }
        cell.configure(event: events[indexPath.row])

        return cell
    }
}
