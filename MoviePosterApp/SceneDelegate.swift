import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var rootCoordinator: RootCoordinator?
    private var serviceLocator: ServiceLocator?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let serviceLocator = ServiceLocator()
        self.serviceLocator = serviceLocator
        let tabBarBuilder = TabBarBuilder(resolver: serviceLocator.getResolver())
        window.rootViewController = tabBarBuilder.build()
        window.makeKeyAndVisible()
        self.window = window
    }
}
