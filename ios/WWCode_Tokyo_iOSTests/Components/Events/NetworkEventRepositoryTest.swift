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
                            "description": "some description",
                            "venue": {
                                "name": "venue name",
                                "lat": 1.23,
                                "lon": 4.56,
                                "address": "venue address",
                                "city": "venue city"
                            }
                          },
                          {
                            "name": "Future Event",
                            "startDateTime": "2020-06-12T10:30:00",
                            "endDateTime": "2020-06-12T18:30:00",
                            "description": "some description",
                            "venue": {
                                "name": "venue name",
                                "lat": 1.23,
                                "lon": 4.56,
                                "address": "venue address",
                                "city": "venue city"
                            }
                          }
                        ]
                       """
                    spyHttp.get_returnPromise.success(jsonResponse.data(using: .utf8)!)
                }

                expect(events?.count).to(equal(2))
                expect(events?.first?.name).to(equal("Tokyo Livehouse"))
                expect(events?.first?.startDateTime).to(equal("2021-06-12T18:30:00"))
                expect(events?.first?.endDateTime).to(equal("2021-06-12T21:30:00"))
                expect(events?.first?.description).to(equal("some description"))
                expect(events?.first?.venue.name).to(equal("venue name"))
                expect(events?.first?.venue.lat).to(equal(1.23))
                expect(events?.first?.venue.lon).to(equal(4.56))
                expect(events?.first?.venue.address).to(equal("venue address"))
                expect(events?.first?.venue.city).to(equal("venue city"))
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
                            "description": "description",
                            "venue": {
                                "name": "venue name",
                                "lat": 1.23,
                                "lon": 4.56,
                                "address": "venue address",
                                "city": "venue city"
                            }
                          }
                        ]
                       """
                    spyHttp.get_returnPromise.success(jsonResponse.data(using: .utf8)!)
                }

                expect(events?.count).to(equal(1))
                expect(events?.first?.name).to(equal("PAL training"))
                expect(events?.first?.startDateTime).to(equal("2020-02-29T19:30:00"))
                expect(events?.first?.endDateTime).to(equal("2020-02-29T21:30:00"))
                expect(events?.first?.description).to(equal("description"))
                expect(events?.first?.venue.name).to(equal("venue name"))
                expect(events?.first?.venue.lat).to(equal(1.23))
                expect(events?.first?.venue.lon).to(equal(4.56))
                expect(events?.first?.venue.address).to(equal("venue address"))
                expect(events?.first?.venue.city).to(equal("venue city"))
            }
        }
    }
}

