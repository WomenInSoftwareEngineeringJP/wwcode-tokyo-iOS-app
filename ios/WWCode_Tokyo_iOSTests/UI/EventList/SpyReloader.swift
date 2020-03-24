@testable import WWCode_Tokyo_iOS

class SpyReloader: Reloader {
    private(set) var reload_wasCalled: Bool = false
    private(set) var reload_argument_reloadable: Reloadable? = nil
    
    func reload(reloadable: Reloadable) {
        reload_wasCalled = true
        reload_argument_reloadable = reloadable
    }
}
