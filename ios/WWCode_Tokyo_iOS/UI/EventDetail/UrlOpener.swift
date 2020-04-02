import WebKit

protocol UrlOpener {
    func openUrl(url: String)
}

class UrlOpenerImpl: UrlOpener {
    func openUrl(url: String) {
        let url = URL(string: url)!
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
