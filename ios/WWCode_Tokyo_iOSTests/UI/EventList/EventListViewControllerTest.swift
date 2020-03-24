import Quick
import Nimble
import Succinct

@testable import WWCode_Tokyo_iOS

final class EventListViewControllerTest: QuickSpec {
    override func spec() {
        
        var subject: EventListViewController!
        var eventRepoSpyStub: SpyStubEventRepo!
        
        let upcomingEvents: [Event] = [
            Event(
                name: "WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic",
                startDateTime: "2021-06-12T18:30:00",
                endDateTime: "2021-06-12T21:30:00",
                description: "",
                venue: Venue(
                    name: "Code Chrysalis",
                    lat: 0,
                    lon: 0,
                    address: "",
                    city: ""
                )
            )
        ]
        
        
        var navigationController: UINavigationController!

        var spyRouter: SpyRouter!
        
        describe("EventsListViewController") {
            beforeEach {
                navigationController = UINavigationController()
                spyRouter = SpyRouter(navigationController: navigationController)
                
                eventRepoSpyStub = SpyStubEventRepo()
                eventRepoSpyStub.getUpcomingEvents_returnUpcomingEvents.success(upcomingEvents)

                subject = EventListViewController(router: spyRouter, eventRepository: eventRepoSpyStub)

                subject.viewDidLoad()
            }
            
            it("get upcoming events from repo") {
                expect(eventRepoSpyStub.getUpcomingEvents_wasCalled).to(beTrue())
            }

            it("displays screen title") {
                expect(subject.hasLabel(withExactText: "Events")).toEventually(beTrue())
            }
            
            it("displays a segmented control with options for upcoming and past") {
                expect(subject.hasLabel(withExactText: "Upcoming")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "Past")).toEventually(beTrue())
            }

            describe("displaying upcoming events") {
                it("displays the event name") {
                    expect(subject.hasLabel(withExactText: "WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic")).toEventually(beTrue())
                }

                it("displays the event venue name") {
                    expect(subject.hasLabel(withExactText: "Code Chrysalis")).toEventually(beTrue())
                }

                it("displays the day of the event based on the start date") {
                    expect(subject.hasLabel(withExactText: "Jun 12, Sat")).toEventually(beTrue())
                }

                it("displays the start and end time of the event formatted for display") {
                    expect(subject.hasLabel(withExactText: "18:30 - 21:30")).toEventually(beTrue())
                }
            }
            
            it("get past events from repo") {
                expect(eventRepoSpyStub.getPastEvents_wasCalled).to(beTrue())
            }
            
            it("tapping on an event shows its detail page") {
                expect(subject.hasLabel(withExactText: "Hackathon 101 with Junction Tokyo")).toEventuallyNot(beNil())
                subject.tableView(subject.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                expect(spyRouter.showEventDetail_wasCalled).to(beTrue())
            }
        }
    }
}
