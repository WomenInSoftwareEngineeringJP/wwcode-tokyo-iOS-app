import Quick
import Nimble
import Succinct

@testable import WWCode_Tokyo_iOS

final class EventsTableViewControllerTest: QuickSpec {
    override func spec() {
        var subject: EventListViewController!
        var eventRepoSpyStub: SpyStubEventRepo!
        let events = [
            Event(name: "WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic", date: "WED 05 FEB", time: "7:30 PM - 9:30 PM", venueName: "Code Chrysalis"),
            Event(name: "Hackathon 101 with Junction Tokyo", date: "WED 05 FEB", time: "7:30 PM - 9:30 PM", venueName: "Code Chrysalis")
        ]

        describe("EventsTableViewController") {
            beforeEach {
                eventRepoSpyStub = SpyStubEventRepo()
                eventRepoSpyStub.getEvents_returnEvents.success(events)
                subject = EventListViewController(eventRepository: eventRepoSpyStub)
                subject.viewDidLoad()
            }
            
            it("get events from repo") {
                expect(eventRepoSpyStub.getEvents_wasCalled).to(beTrue())
            }
            
            it("display events from repo") {
                expect(subject.hasLabel(withExactText: "WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "7:30 PM - 9:30 PM")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "WED 05 FEB")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "Code Chrysalis")).toEventually(beTrue())
            }
        }
    }
}
