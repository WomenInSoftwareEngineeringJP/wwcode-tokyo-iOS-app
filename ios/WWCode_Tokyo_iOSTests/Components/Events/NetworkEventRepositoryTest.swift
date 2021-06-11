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
            
            it("returns events for in person events") {
                var events: [Event]? = nil
                AsyncExpectation.execute() { expectation in
                    eventRepository
                        .getUpcomingEvents()
                        .onSuccess { returnedEvents in
                            events = returnedEvents
                            expectation.fulfill()
                        }

                    let jsonResponse = """
                        [
                          {
                            "name": "Tokyo Livehouse",
                            "startDateTime": "2021-06-12T18:30:00",
                            "endDateTime": "2021-06-12T21:30:00",
                            "description": "some description",
                            "venue": {
                                "name": "venue name",
                                "location": {
                                    "lat": 1.23,
                                    "lon": 4.56,
                                    "address": "venue address",
                                    "city": "venue city"
                                }
                            },
                            "link": "example.com"
                          },
                          {
                            "name": "Future Event",
                            "startDateTime": "2020-06-12T10:30:00",
                            "endDateTime": "2020-06-12T18:30:00",
                            "description": "some description",
                            "venue": {
                                "name": "venue name",
                                "location": {
                                    "lat": 1.23,
                                    "lon": 4.56,
                                    "address": "venue address",
                                    "city": "venue city"
                                }
                            },
                            "link": "example2.com"
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
                expect(events?.first?.venue?.name).to(equal("venue name"))
                expect(events?.first?.venue?.location?.lat).to(equal(1.23))
                expect(events?.first?.venue?.location?.lon).to(equal(4.56))
                expect(events?.first?.venue?.location?.address).to(equal("venue address"))
                expect(events?.first?.venue?.location?.city).to(equal("venue city"))
                expect(events?.first?.link).to(equal("example.com"))
            }

            it("returns events for in online events") {
                var events: [Event]? = nil
                AsyncExpectation.execute() { expectation in
                    eventRepository
                        .getUpcomingEvents()
                        .onSuccess { returnedEvents in
                            events = returnedEvents
                            expectation.fulfill()
                        }

                    let jsonResponse = """
                        [
                          {
                            "name": "Online Livehouse",
                            "startDateTime": "2021-06-12T18:30:00",
                            "endDateTime": "2021-06-12T21:30:00",
                            "description": "some description",
                            "venue": {
                                "name": "Online event",
                                "location": null
                            },
                            "link": "example.com"
                          }
                        ]
                       """
                    spyHttp.get_returnPromise.success(jsonResponse.data(using: .utf8)!)
                }

                expect(events?.count).to(equal(1))
                expect(events?.first?.name).to(equal("Online Livehouse"))
                expect(events?.first?.startDateTime).to(equal("2021-06-12T18:30:00"))
                expect(events?.first?.endDateTime).to(equal("2021-06-12T21:30:00"))
                expect(events?.first?.description).to(equal("some description"))
                expect(events?.first?.venue?.name).to(equal("Online event"))
                expect(events?.first?.venue?.location).to(beNil())
                expect(events?.first?.link).to(equal("example.com"))
            }

            it("returns events events with no venue") {
                var events: [Event]? = nil
                AsyncExpectation.execute() { expectation in
                    eventRepository
                        .getUpcomingEvents()
                        .onSuccess { returnedEvents in
                            events = returnedEvents
                            expectation.fulfill()
                        }

                    let jsonResponse = """
                        [
                          {
                            "name": "Online Livehouse",
                            "startDateTime": "2021-06-12T18:30:00",
                            "endDateTime": "2021-06-12T21:30:00",
                            "description": "some description",
                            "venue": null,
                            "link": "example.com"
                          }
                        ]
                       """
                    spyHttp.get_returnPromise.success(jsonResponse.data(using: .utf8)!)
                }

                expect(events?.count).to(equal(1))
                expect(events?.first?.name).to(equal("Online Livehouse"))
                expect(events?.first?.startDateTime).to(equal("2021-06-12T18:30:00"))
                expect(events?.first?.endDateTime).to(equal("2021-06-12T21:30:00"))
                expect(events?.first?.description).to(equal("some description"))
                expect(events?.first?.venue).to(beNil())
                expect(events?.first?.link).to(equal("example.com"))
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

                    let jsonResponse = """
                        [
                          {
                            "name": "PAL training",
                            "startDateTime": "2020-02-29T19:30:00",
                            "endDateTime": "2020-02-29T21:30:00",
                            "description": "description",
                            "venue": {
                                "name": "venue name",
                                "location": {
                                    "lat": 1.23,
                                    "lon": 4.56,
                                    "address": "venue address",
                                    "city": "venue city"
                                }
                            },
                            "link": "example.com"
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
                expect(events?.first?.venue?.name).to(equal("venue name"))
                expect(events?.first?.venue?.location?.lat).to(equal(1.23))
                expect(events?.first?.venue?.location?.lon).to(equal(4.56))
                expect(events?.first?.venue?.location?.address).to(equal("venue address"))
                expect(events?.first?.venue?.location?.city).to(equal("venue city"))
                expect(events?.first?.link).to(equal("example.com"))
            }
        }
    }
}

