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
            it("shows event description"){
                expect(subject.hasLabel(withExactText: "WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic")).to(beTrue())
                expect(subject.hasLabel(withExactText: "7:30 PM - 9:30 PM")).to(beTrue())
                expect(subject.hasLabel(withExactText: "WED 05 FEB")).to(beTrue())
                expect(subject.hasLabel(withExactText: "Code Chrysalis")).to(beTrue())
            }
        }
        
    }
}
