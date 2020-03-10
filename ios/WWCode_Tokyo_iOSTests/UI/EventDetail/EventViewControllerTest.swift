import Quick
import Nimble
import Succinct

@testable import WWCode_Tokyo_iOS

final class EventViewControllerTest: QuickSpec {
    override func spec() {
        var subject: EventViewController!
        
        beforeEach {
            let eventRepo = SpyStubEventRepo()
            subject = EventViewController(repo: eventRepo)
        }
        
        describe("EventViewController") {
            it("shows event") {
                expect(subject.hasLabel(withExactText: "PAL training!")).to(beTrue())
            }
        }
    }
}
