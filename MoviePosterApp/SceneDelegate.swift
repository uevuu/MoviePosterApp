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
//        let serviceLocator = ServiceLocator()
        let tabBarBuilder = TabBarBuilder()
        window.rootViewController = tabBarBuilder.build()
        window.makeKeyAndVisible()
        self.window = window
//        self.serviceLocator = serviceLocator
//        self.rootCoordinator = RootCoordinator(window: window, resolver: serviceLocator.getResolver())
//        rootCoordinator?.start(animated: true)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
