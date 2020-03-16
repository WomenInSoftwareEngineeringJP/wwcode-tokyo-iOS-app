import Quick
import Nimble

@testable import WWCode_Tokyo_iOS

class NetworkEventRepositoryTest: QuickSpec {
    override func spec() {
        var eventRepository: NetworkEventRepository!
        var spyHttp: SpyHttp!
        
        describe("the network EventRepository") {
            beforeEach {
              spyHttp = SpyHttp()
              eventRepository = NetworkEventRepository(http: spyHttp)
            }

            it("getUpcomingEvents requests GET /api/events/upcoming") {
                let _ = eventRepository.getUpcomingEvents()
                
                expect(spyHttp.get_argument_endpoint).to(equal("/api/events/upcoming"))
            }
            
            it("get upcoming events return upcoming events") {
                var events: [Event]? = nil
                AsyncExpectation.execute() { expectation in
                    eventRepository
                        .getUpcomingEvents()
                        .onSuccess { returnedEvents in
                            events = returnedEvents
                            expectation.fulfill()
                        }

                    // We can use a multi-string literal
                    let jsonResponse = """
                        [
                          {
                            "name": "Tokyo Livehouse",
                            "startDateTime": "2021-06-12T18:30:00",
                            "endDateTime": "2021-06-12T21:30:00",
                            "venueName": "Tokyo Dome"
                          },
                          {
                          "name": "Future Event",
                          "startDateTime": "2020-06-12T10:30:00",
                          "endDateTime": "2020-06-12T18:30:00",
                          "venueName": "Yokohama Park"
                          }
                        ]
                       """
                    spyHttp.get_returnPromise.success(jsonResponse.data(using: .utf8)!)
                }

                expect(events?.count).to(equal(2))
                expect(events?.first?.name).to(equal("Tokyo Livehouse"))
                expect(events?.first?.startDateTime).to(equal("2021-06-12T18:30:00"))
                expect(events?.first?.endDateTime).to(equal("2021-06-12T21:30:00"))
                expect(events?.first?.venueName).to(equal("Tokyo Dome"))

            }
            
            it("getPastEvents requests GET /api/events/past") {
                let _ = eventRepository.getPastEvents()
                
                expect(spyHttp.get_argument_endpoint).to(equal("/api/events/past"))
            }
            
            it("get past events return past events") {
                var events: [Event]? = nil                
                AsyncExpectation.execute() { expectation in
                    eventRepository
                        .getPastEvents()
                        .onSuccess { returnedEvents in
                            events = returnedEvents
                            expectation.fulfill()
                        }

                    // We can use a multi-string literal
                    let jsonResponse = """
                        [
                          {
                            "name": "PAL training",
                            "startDateTime": "2020-02-29T19:30:00",
                            "endDateTime": "2020-02-29T21:30:00",
                            "venueName": "Code Chrysalis"
                          }
                        ]
                       """
                    spyHttp.get_returnPromise.success(jsonResponse.data(using: .utf8)!)
                }

                expect(events?.count).to(equal(1))
                expect(events?.first?.name).to(equal("PAL training"))
                expect(events?.first?.startDateTime).to(equal("2020-02-29T19:30:00"))
                expect(events?.first?.endDateTime).to(equal("2020-02-29T21:30:00"))
                expect(events?.first?.venueName).to(equal("Code Chrysalis"))
            }
        }
    }
}

