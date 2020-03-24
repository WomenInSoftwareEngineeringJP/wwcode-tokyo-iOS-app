import Quick
import Nimble

@testable import WWCode_Tokyo_iOS

class DefaultReloaderTest: QuickSpec {
    override func spec() {
        describe("default reloader") {
            it("calls reloadData on the reloadable object") {
                let spyReloadable = SpyReloadable()
                let subject = DefaultReloader()
                
                
                subject.reload(reloadable: spyReloadable)
                
                
                expect(spyReloadable.reloadData_wasCalled).to(beTrue())
            }
        }
    }
}
