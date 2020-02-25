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
     
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.red
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
