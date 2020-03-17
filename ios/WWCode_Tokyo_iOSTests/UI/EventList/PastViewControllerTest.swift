import Quick
import Nimble
import Succinct

@testable import WWCode_Tokyo_iOS

final class PastViewControllerTest: QuickSpec {
    override func spec() {
        var subject: PastEventsViewController!
        let pastEvents = [EventFixture.Hackathon()]

        describe("EventsListViewController") {
            beforeEach {
                subject = PastEventsViewController(pastEvents: pastEvents)
                subject.viewDidLoad()
            }
            
            xit("display past events from repo") {
                expect(subject.hasLabel(withExactText: "Hackathon 101 with Junction Tokyo")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "18:30 - 21:30")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "Jun 12, Sat")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "Mercari")).toEventually(beTrue())
            }
        }
    }
}
