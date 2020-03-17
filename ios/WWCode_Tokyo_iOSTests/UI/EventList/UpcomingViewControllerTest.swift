import Quick
import Nimble
import Succinct

@testable import WWCode_Tokyo_iOS

final class UpcomingViewControllerTest: QuickSpec {
    override func spec() {
        var subject: UpcomingEventsViewController!
        let upcomingEvents = [EventFixture.JavaScript()]

        describe("EventsListViewController") {
            beforeEach {
                subject = UpcomingEventsViewController(upcomingEvents: upcomingEvents)
                subject.viewDidLoad()
            }
            
            xit("display upcoming events from repo") {
                expect(subject.hasLabel(withExactText: "WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "18:30 - 21:30")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "Jun 12, Sat")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "Code Chrysalis")).toEventually(beTrue())
            }
        }
    }
}
