//
//  TabbarController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/5/24.
//

import UIKit

class CompanyTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        self.tabBar.items?[0].selectedImage = UIImage(named: Helper.shared.isRTL() ? "home-ar" : "home-en")
        self.tabBar.items?[1].selectedImage = UIImage(named: Helper.shared.isRTL() ? "properties-ar" : "properties-en")
        self.tabBar.items?[2].selectedImage = UIImage(named: Helper.shared.isRTL() ? "worker-ar" : "worker-en")
        self.tabBar.items?[3].selectedImage = UIImage(named: Helper.shared.isRTL() ? "language-ar" : "language-en")
    }
}