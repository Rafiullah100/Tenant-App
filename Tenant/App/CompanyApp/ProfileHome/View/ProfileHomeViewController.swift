//
//  ProfileHomeViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 8/8/24.
//

import UIKit
import CoreLocation
class ProfileHomeViewController: BaseViewController {
    let profileInfo = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompanyProfileViewController") as! CompanyProfileViewController
    let branchVC = UIStoryboard(name: Storyboard.company.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddBranchViewController") as! AddBranchViewController

    @IBOutlet weak var branchButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .company
        viewControllerTitle = LocalizationKeys.editProfile.rawValue.localizeString()
        self.add(profileInfo, in: containerView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func branchBtnAction(_ sender: Any) {
        branchButton.backgroundColor = CustomColor.appColor.color
        infoButton.backgroundColor = CustomColor.grayColor.color
        branchVC.branchesList = profileInfo.branches
        self.add(branchVC, in: containerView)
    }
    
    @IBAction func infoBtnAction(_ sender: Any) {
        branchButton.backgroundColor = CustomColor.grayColor.color
        infoButton.backgroundColor = CustomColor.appColor.color
        self.add(profileInfo, in: containerView)
    }
}
