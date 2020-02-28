import Quick
import Nimble
import Succinct

@testable import WWCode_Tokyo_iOS

final class EventsTableViewControllerTest: QuickSpec {
    override func spec() {
        var subject: EventTableViewController!
        
        beforeEach {
            subject = EventTableViewController(fakeRepo: FakeEventRepo())
        }
        
        describe("EventsTableViewController") {
            it("shows events") {
                expect(subject.hasLabel(withExactText: "PAL training!")).to(beTrue())
                expect(subject.hasLabel(withExactText: "Lunch and learn")).to(beTrue())
                expect(subject.hasLabel(withExactText: "Tokyo Olympics")).to(beTrue())
            }
        }
    }
}
