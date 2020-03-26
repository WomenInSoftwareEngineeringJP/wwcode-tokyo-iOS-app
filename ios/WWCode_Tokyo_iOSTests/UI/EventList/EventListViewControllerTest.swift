import Quick
import Nimble
import Succinct

@testable import WWCode_Tokyo_iOS

final class EventListViewControllerTest: QuickSpec {
    override func spec() {
        
        var subject: EventListViewController!
        var spyStubEventRepo: SpyStubEventRepo!
        
        var spyRouter: SpyRouter!
        var spyReloader: SpyReloader!
        
        describe("EventsListViewController") {
            beforeEach {
                let navigationController = UINavigationController()
                spyRouter = SpyRouter(navigationController: navigationController)
                
                spyStubEventRepo = SpyStubEventRepo()
                spyReloader = SpyReloader()

                subject = EventListViewController(
                    router: spyRouter,
                    eventRepository: spyStubEventRepo,
                    reloader: spyReloader
                )
                subject.loadViewControllerForUnitTest()
            }
            
            it("get upcoming events from repo") {
                expect(spyStubEventRepo.getUpcomingEvents_wasCalled).to(beTrue())
            }

            it("displays screen title") {
                expect(subject.hasLabel(withExactText: "Events")).toEventually(beTrue())
            }
            
            xit("displays a segmented control with options for upcoming and past") {
                expect(subject.hasLabel(withExactText: "Upcoming")).toEventually(beTrue())
                expect(subject.hasLabel(withExactText: "Past")).toEventually(beTrue())
            }
            
            it("defaults to showing upcoming events") {
                expect(subject.hasSegmentedControlSegmentSelected(withExactText: "Upcoming")).to(beTrue())
            }

            describe("displaying upcoming events") {
                beforeEach {
                    let upcomingEvents: [Event] = [
                        Event(
                            name: "WTF is JavaScript",
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

                    spyStubEventRepo.getUpcomingEvents_returnUpcomingEvents.success(upcomingEvents)
                }
                
                it("reloads the table view") {
                    expect(spyReloader.reload_wasCalled).toEventually(beTrue())
                    expect(spyReloader.reload_argument_reloadable)
                        .toEventually(beAKindOf(UITableView.self))
                    expect(spyReloader.reload_argument_reloadable)
                        .toEventually(be(subject.tableView))
                }
                
                it("displays the event name") {
                    expect(subject.hasLabel(withExactText: "WTF is JavaScript")).toEventually(beTrue())
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

                describe("tapping on an event cell") {
                    it("navigates to the detail page") {
                        let waitForTableViewToFinishReloading: () -> Void = {
                            expect(subject.hasLabel(withExactText: "WTF is JavaScript")).toEventuallyNot(beNil())
                        }
                        waitForTableViewToFinishReloading()


                        subject.tapCell(withExactText: "WTF is JavaScript")


                        expect(spyRouter.showEventDetail_wasCalled).to(beTrue())
                    }
                }
            }
            
            describe("displaying past events when past segment selected") {
                beforeEach {
                    let pastEvents: [Event] = [
                        Event(
                            name: "Past Event",
                            startDateTime: "2020-02-12T18:00:00",
                            endDateTime: "2020-02-12T21:00:00",
                            description: "",
                            venue: Venue(
                                name: "Indeed",
                                lat: 0,
                                lon: 0,
                                address: "",
                                city: ""
                            )
                        )
                    ]
                    spyStubEventRepo.getPastEvents_returnPastEvents.success(pastEvents)


                    subject.selectSegment(withTitleText: "Past")
                }

                it("get past events from repo") {
                    expect(spyStubEventRepo.getPastEvents_wasCalled).to(beTrue())
                }

                it("reloads the table view") {
                    expect(spyReloader.reload_wasCalled).toEventually(beTrue())
                    expect(spyReloader.reload_argument_reloadable)
                        .toEventually(beAKindOf(UITableView.self))
                }

                it("displays the event name") {
                    expect(subject.hasLabel(withExactText: "Past Event")).toEventually(beTrue())
                }

                it("displays the event venue name") {
                    expect(subject.hasLabel(withExactText: "Indeed")).toEventually(beTrue())
                }

                it("displays the day of the event based on the start date") {
                    expect(subject.hasLabel(withExactText: "Feb 12, Wed")).toEventually(beTrue())
                }

                it("displays the start and end time of the event formatted for display") {
                    expect(subject.hasLabel(withExactText: "18:00 - 21:00")).toEventually(beTrue())
                }
                
                it("show upcoming event when upcoming segment is selected") {
                    let upcomingEvents: [Event] = [
                        Event(
                            name: "WTF is JavaScript",
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

                    spyStubEventRepo.getUpcomingEvents_returnUpcomingEvents.success(upcomingEvents)
                    
                    
                    subject.selectSegment(withTitleText: "Upcoming")
                    
                    expect(subject.hasLabel(withExactText: "WTF is JavaScript")).toEventually(beTrue())
                    expect(subject.hasLabel(withExactText: "Past Event")).toEventually(beFalse())
                }

            }
        }
    }
}
