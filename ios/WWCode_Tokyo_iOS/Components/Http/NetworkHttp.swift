import Foundation
import BrightFutures

protocol NetworkSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkSession {}

struct NetworkHttp: Http {
    let baseUrl: String
    let networkSession: NetworkSession
    
    func get(url endpoint: String) -> Future<Data, HttpError> {
        let requestPromise = Promise<Data, HttpError>()
        
        let urlString = baseUrl + endpoint
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        
        let _ = networkSession
            .dataTask(with: urlRequest) { (maybeData, maybeUrlResponse, maybeError) in
                if let data = maybeData {
                    requestPromise.success(data)
                }
            }
            .resume()
        
        return requestPromise.future
    }
}
