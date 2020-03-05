import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let http = NetworkHttp(baseUrl: "http://localhost:8080/", networkSession: URLSession.shared)
        let eventRepo = NetworkEventRepository(http: http)
        let viewController = EventTableViewController(eventRepository: eventRepo)

        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
