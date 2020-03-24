protocol Reloadable {
    func reloadData()
}

protocol Reloader {
    func reload(reloadable: Reloadable)
}

import UIKit
extension UITableView: Reloadable {}
