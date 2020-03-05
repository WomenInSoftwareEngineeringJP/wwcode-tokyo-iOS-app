import Quick
import Nimble
@testable import WWCode_Tokyo_iOS

class NetworkHttpSpec: QuickSpec {
    override func spec() {
        var networkHttp: NetworkHttp!

        describe("http get requests") {
            it("makes a request to the correct endpoint") {
                // This test uses the SpyNetworkSession since we are only spying on the data sent to it.
                let spyNetworkSession = SpyNetworkSession()
                networkHttp = NetworkHttp(
                    baseUrl: "http://www.example.com",
                    networkSession: spyNetworkSession
                )
                
                
                let _ = networkHttp.get(url: "/api/events")
                
                
                let actualUrlString = spyNetworkSession.dataTask_argument_request?.url?.absoluteString
                expect(actualUrlString).to(equal("http://www.example.com/api/events"))
            }
            
            it("ensures that newly initialized network data tasks call resume() to initiate the request") {
                let fakeNetworkSession = FakeNetworkSession()
                networkHttp = NetworkHttp(
                    baseUrl: "http://www.example.com",
                    networkSession: fakeNetworkSession
                )
                
                let spySessionDataTask = SpySessionDataTask()
                fakeNetworkSession.dataTask_returnValue = spySessionDataTask
                
                
                let _ = networkHttp.get(url: "")
                
                
                expect(spySessionDataTask.resume_wasCalled).to(beTrue())
            }
            
            it("returns a future which resolves the request with response data") {
                // This test uses the FakeNetworkSession to allow us to set data on the dataTask.
                let fakeNetworkSession = FakeNetworkSession()
                networkHttp = NetworkHttp(
                    baseUrl: "http://www.example.com",
                    networkSession: fakeNetworkSession
                )

                let responseData = "GET Response".data(using: String.Encoding.utf8)
                fakeNetworkSession.dataTask_completionHandler_inputs = (
                    maybeData: responseData,
                    maybeResponse: nil,
                    maybeError: nil
                )
                
                
                let maybeResponseFuture = networkHttp.get(url: "http://www.example.com")
                
                var actualData: Data?
                maybeResponseFuture.onSuccess { data in
                    actualData = data
                }
                
                
                expect(actualData).toEventually(equal(responseData))
            }
        }
    }
}
