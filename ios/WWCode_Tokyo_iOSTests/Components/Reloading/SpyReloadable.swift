@testable import WWCode_Tokyo_iOS

class SpyReloadable: Reloadable {
    private(set) var reloadData_wasCalled: Bool = false
    func reloadData() {
        reloadData_wasCalled = true
    }
}
