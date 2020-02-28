import UIKit

class EventTableViewController: UITableViewController {
    private var events: [Event]!
    
    init(fakeRepo: FakeEventRepo) {
        super.init(nibName: nil, bundle: nil)
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell : UITableViewCell!
         cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
         if cell == nil {
             cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
         }

        cell.textLabel?.text = events[indexPath.row].name
        return cell
    }
}
