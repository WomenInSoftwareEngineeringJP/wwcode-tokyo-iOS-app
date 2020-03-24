protocol Reloadable {
    func reloadData()
}

protocol Reloader {
    func reload(reloadable: Reloadable)
}

struct DefaultReloader: Reloader {
    func reload(reloadable: Reloadable) {
        reloadable.reloadData()
    }
}

import UIKit
extension UITableView: Reloadable {}
