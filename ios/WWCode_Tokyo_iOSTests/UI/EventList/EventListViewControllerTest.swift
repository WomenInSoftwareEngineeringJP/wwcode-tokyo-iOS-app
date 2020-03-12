import Quick
import Nimble
import Succinct

@testable import WWCode_Tokyo_iOS

final class EventListViewControllerTest: QuickSpec {
    override func spec() {
        var subject: EventListViewController!
        var eventRepoSpyStub: SpyStubEventRepo!
        let upcomingEvents = [EventFixture.JavaScript()]
        let pastEvents = [EventFixture.Hackathon()]

        describe("EventsListViewController") {
            beforeEach {
                eventRepoSpyStub = SpyStubEventRepo()
                eventRepoSpyStub.getUpcomingEvents_returnUpcomingEvents.success(upcomingEvents)
                eventRepoSpyStub.getPastEvents_returnPastEvents.success(pastEvents)
                subject = EventListViewController(eventRepository: eventRepoSpyStub)
                subject.viewDidLoad()
            }
            
            it("get upcoming events from repo") {
                expect(eventRepoSpyStub.getUpcomingEvents_wasCalled).to(beTrue())
            }

            it("displays screen title") {
                expect(subject.hasLabel(withExactText: "Events")).toEventually(beTrue())
            }

            it("displays section titles") {
                expect(subject.hasLabel(withExactText: "Upcoming")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "Past")).toEventually(beTrue())
            }

            it("display upcoming events from repo") {
                expect(subject.hasLabel(withExactText: "WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "7:30 PM - 9:30 PM")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "WED 11 MAR")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "Code Chrysalis")).toEventually(beTrue())
            }
            
            it("get past events from repo") {
                expect(eventRepoSpyStub.getPastEvents_wasCalled).to(beTrue())
            }

            it("display past events from repo") {
                expect(subject.hasLabel(withExactText: "Hackathon 101 with Junction Tokyo")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "6:30 PM - 9:30 PM")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "WED 05 FEB")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "Mercari")).toEventually(beTrue())
            }
        }
    }
}
