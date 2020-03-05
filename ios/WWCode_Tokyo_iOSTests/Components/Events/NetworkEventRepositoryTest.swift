import Quick
import Nimble

@testable import WWCode_Tokyo_iOS

class NetworkEventRepositoryTest: QuickSpec {
    override func spec() {
        var eventRepository: NetworkEventRepository!
        
        describe("the network EventRepository") {
            var spyHttp: SpyHttp!

            it("getEvents requests GET /api/events") {
                spyHttp = SpyHttp()
                eventRepository = NetworkEventRepository(http: spyHttp)

                let _ = eventRepository.getEvents()
                
                expect(spyHttp.get_argument_endpoint).to(equal("/api/events"))
            }
            
            it("get events return events") {
                var events: [Event]? = nil
                AsyncExpectation.execute() { expectation in
                    eventRepository
                        .getEvents()
                        .onSuccess { returnedEvents in
                            events = returnedEvents
                            expectation.fulfill()
                        }

                    // We can use a multi-string literal
                    let jsonResponse = """
                        [
                          {
                            "name": "PAL training",
                            "date": "2020/02/29",
                            "time": "19:30 - 21:30",
                            "venueName": "Code Chrysalis"
                          },
                          {
                            "name": "Tokyo Livehouse",
                            "date": "2020/04/10",
                            "time": "19:30 - 21:30",
                            "venueName": "Tokyo Dome"
                          }
                        ]
                       """
                    spyHttp.get_returnPromise.success(jsonResponse.data(using: .utf8)!)
                }
                
                expect(events?.count).to(equal(2))
                expect(events?.first?.name).to(equal("PAL training"))
                expect(events?.first?.date).to(equal("2020/02/29"))
                expect(events?.first?.time).to(equal("19:30 - 21:30"))
                expect(events?.first?.venueName).to(equal("Code Chrysalis"))
            
            }
        }
    }
}

