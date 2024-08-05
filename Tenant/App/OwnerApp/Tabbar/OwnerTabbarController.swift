//
//  TabbarController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/5/24.
//

import UIKit

class OwnerTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    
        self.tabBar.items?[0].selectedImage = UIImage(named: Helper.shared.isRTL() ? "home-ar" : "home-en")
        self.tabBar.items?[1].selectedImage = UIImage(named: Helper.shared.isRTL() ? "properties-ar" : "properties-en")
        self.tabBar.items?[2].selectedImage = UIImage(named: Helper.shared.isRTL() ? "self-complaints-selected" : "self-complaints-selected")
        self.tabBar.items?[3].selectedImage = UIImage(named: Helper.shared.isRTL() ? "language-ar" : "language-en")
        addTopBorderToTabBar()
    }

    func addTopBorderToTabBar() {
        let borderWidth: CGFloat = 0.5
        let borderColor = CustomColor.grayColor.color.cgColor

        // Create the border view
        let borderView = UIView()
        borderView.backgroundColor = UIColor.clear
        borderView.layer.borderColor = borderColor
        borderView.layer.borderWidth = borderWidth
        borderView.translatesAutoresizingMaskIntoConstraints = false

        // Add the border view to the tab bar
        tabBar.addSubview(borderView)

        // Set the constraints for the border view
        NSLayoutConstraint.activate([
            borderView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            borderView.topAnchor.constraint(equalTo: tabBar.topAnchor),
            borderView.heightAnchor.constraint(equalToConstant: borderWidth)
        ])
    }
}
