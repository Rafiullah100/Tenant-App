//
//  SceneDelegate.swift
//  Tenant
//
//  Created by MacBook Pro on 6/10/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        if UserDefaults.standard.isLogin == true{
            
//            let vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TenantHomeViewController") as! TenantHomeViewController
//            let nav = UINavigationController(rootViewController: vc)
            let vc: UIViewController?
            
            switch Helper.shared.userType() {
            case .owner:
//                UserDefaults.standard.token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiY29udGFjdCI6IjIzODQ3OTI4MyIsImlhdCI6MTcyMTcxNjU3MSwiZXhwIjoxNzUzMjUyNTcxfQ.SrReVUcX0j-LTvGUlHNJBxEq-dKwVJSfUVisO_CHfC8"
                vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "OwnerTabbarController") as! OwnerTabbarController
            case .tenant:
                vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TenantHomeViewController") as! TenantHomeViewController
            case .company:
                vc = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyTabbarController") as! CompanyTabbarController
            case .worker:
                UserDefaults.standard.token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiY29udGFjdCI6IjIzODQ3OTI4MyIsImlhdCI6MTcyMTcxNjU3MSwiZXhwIjoxNzUzMjUyNTcxfQ.SrReVUcX0j-LTvGUlHNJBxEq-dKwVJSfUVisO_CHfC8"
                vc = UIStoryboard(name: Storyboard.worker.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WorkersHomeViewController") as! WorkersHomeViewController
            }
            let nav = UINavigationController(rootViewController: vc ?? UIViewController())
//
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }
        else{
            let vc = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: "IntroductionViewController") as! IntroductionViewController
            let nav = UINavigationController(rootViewController: vc)
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

