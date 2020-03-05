import Foundation
import BrightFutures

@testable import WWCode_Tokyo_iOS

class SpyHttp: Http {
       private(set) var get_argument_endpoint: String? = nil
       private(set) var get_returnPromise = Promise<Data, HttpError>()

    func get(url endpoint: String) -> Future<Data, HttpError> {
           get_argument_endpoint = endpoint
           return get_returnPromise.future
       }
}
