//
//  Switcher.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/1/23.
//


import Foundation
import UIKit
class Switcher {
    
    static func gotoSigninScreen(delegate: UIViewController, userType: UserType){
        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SigninViewController") as! SigninViewController
        vc.userType = userType
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
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
    
    static func gotoOwnerHome(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "OwnerTabbarController") as! OwnerTabbarController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoCompanyScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyTabbarController") as! CompanyTabbarController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoWorkerScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.worker.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WorkersHomeViewController") as! WorkersHomeViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoOwnerScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WorkersHomeViewController") as! WorkersHomeViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoTenantDetailScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TenantDetailViewController") as! TenantDetailViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoCompanyProfile(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyProfileViewController") as! CompanyProfileViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoTenantCompletedDetailScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "TenantCompletedViewController") as! TenantCompletedViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoPendingDetail(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyPendingController") as! CompanyPendingController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoCompletedDetail(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyCompletedViewController") as! CompanyCompletedViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoWorkerDetailScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.worker.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WorkerDetailViewController") as! WorkerDetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoWorkerOngoingDetailScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.worker.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WorkerOngoingDetailViewController") as! WorkerOngoingDetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoWorkerListScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.worker.rawValue, bundle: nil).instantiateViewController(withIdentifier: "WorkersHomeViewController") as! WorkersHomeViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoPropertyDetail(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "PropertyDetailViewController") as! PropertyDetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoRemoveTenant(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "RemoveTenanatViewController") as! RemoveTenanatViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoAddTenant(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddTenanToFlatViewController") as! AddTenanToFlatViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoContactList(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ContactPersonViewController") as! ContactPersonViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoOwnerDetail(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "OwnerDetailViewController") as! OwnerDetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
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
    
    static func gotoAddComplaintScreen(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.tenant.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddTenantViewController") as! AddTenantViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoFlatasHomeVC(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SelfPropertyDetailViewController") as! SelfPropertyDetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoAddFlat(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.owner.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddFlatViewController") as! AddFlatViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)

        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .overCurrentContext
        delegate.present(navController, animated: true)
    }
}
