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
        
        var navigationController: UINavigationController!

        var spyRouter: SpyRouter!
        
        describe("EventsListViewController") {
            beforeEach {
                navigationController = UINavigationController()
                spyRouter = SpyRouter(navigationController: navigationController)
                
                eventRepoSpyStub = SpyStubEventRepo()
                eventRepoSpyStub.getUpcomingEvents_returnUpcomingEvents.success(upcomingEvents)
                eventRepoSpyStub.getPastEvents_returnPastEvents.success(pastEvents)

                subject = EventListViewController(router: spyRouter, eventRepository: eventRepoSpyStub)

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
                expect(subject.hasLabel(withExactText: "18:30 - 21:30")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "Jun 12, Sat")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "Code Chrysalis")).toEventually(beTrue())
            }
            
            it("get past events from repo") {
                expect(eventRepoSpyStub.getPastEvents_wasCalled).to(beTrue())
            }

            it("display past events from repo") {
                expect(subject.hasLabel(withExactText: "Hackathon 101 with Junction Tokyo")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "18:30 - 21:30")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "Jun 12, Sat")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "Mercari")).toEventually(beTrue())
            }
            
            it("tapping on an event shows its detail page") {
                expect(subject.hasLabel(withExactText: "Hackathon 101 with Junction Tokyo")).toEventuallyNot(beNil())
                subject.tableView(subject.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                expect(spyRouter.showEventDetail_wasCalled).to(beTrue())
            }
        }
    }
}
