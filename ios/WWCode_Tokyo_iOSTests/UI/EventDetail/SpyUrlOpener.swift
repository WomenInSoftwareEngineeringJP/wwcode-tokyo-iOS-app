@testable import WWCode_Tokyo_iOS

class SpyUrlOpener: UrlOpener {
    var opened_url: String!
    
    func openUrl(url: String) {
        opened_url = url
    }
}
