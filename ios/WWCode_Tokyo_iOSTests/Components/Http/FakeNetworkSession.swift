import Foundation
@testable import WWCode_Tokyo_iOS

class FakeNetworkSession: NetworkSession {
    var dataTask_completionHandler_inputs: (maybeData: Data?, maybeResponse: URLResponse?, maybeError: Error?) = (nil, nil, nil)
    var dataTask_returnValue: SpySessionDataTask? = nil
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    {
        completionHandler(
            dataTask_completionHandler_inputs.maybeData,
            nil,
            nil
        )

        return dataTask_returnValue ?? SpySessionDataTask()
    }
}
