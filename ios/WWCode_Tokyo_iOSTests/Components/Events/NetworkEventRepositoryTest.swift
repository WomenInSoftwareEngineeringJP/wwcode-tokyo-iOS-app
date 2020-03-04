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
        }
    }
}
