//
//  Switcher.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/1/23.
//


import Foundation
import UIKit
class Switcher {
    
    static func gotoSignupScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoTenantScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TenantHomeViewController") as! TenantHomeViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoMaintenanceScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.maintenance.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TabbarController") as! TabbarController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoTenantDetailScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TenantDetailViewController") as! TenantDetailViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoTenantCompletedDetailScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TenantCompletedViewController") as! TenantCompletedViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoMaintenanceDetail(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.maintenance.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MaintenaceDetailViewController") as! MaintenaceDetailViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
//
//    static func gotoHome(delegate: UIViewController){
//        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
//        UIWindow.key.rootViewController = vc
//        UIWindow.key.makeKeyAndVisible()
//    }
//    
//    static func gotoNewsDetailVC(delegate: UIViewController, type: NewsType, index: IndexPath? = nil, newsID: Int? = nil, opinionID: Int? = nil){
//        let vc = UIStoryboard(name: Storyboard.news.rawValue, bundle: nil).instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
//        vc.newsType = type
//        vc.index = index
//        vc.newsDetailID = newsID
//        vc.opinionDetailID = opinionID
//        vc.modalPresentationStyle = .fullScreen
//        delegate.navigationController?.pushViewController(vc, animated: true)
//    }
    
    
}
