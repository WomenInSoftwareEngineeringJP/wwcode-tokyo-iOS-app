import Quick
import Nimble

@testable import WWCode_Tokyo_iOS

class SpyHttp: Http {
    private(set) var get_argument_endpoint: String? = nil
    
    func get(url: String) {
        get_argument_endpoint = url
    }
}
