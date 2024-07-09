//
//  SignupViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 6/28/24.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var curveImageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var chooseLabel: UILabel!
    @IBOutlet weak var signupLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        curveImageView.image = UIImage(named: Helper.shared.isRTL() ? "bg-ar" : "bg")
        signupLabel.text = LocalizationKeys.signup.rawValue.localizeString()
        chooseLabel.text = LocalizationKeys.chooseOne.rawValue.localizeString()
        continueButton.setTitle(LocalizationKeys.continuee.rawValue.localizeString(), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func ownerBtnAction(_ sender: Any) {
    }
    
    @IBAction func tenantBtnAction(_ sender: Any) {
        Switcher.gotoTenantScreen(delegate: self)
    }
    
    @IBAction func maintenanceBtnAction(_ sender: Any) {
        Switcher.gotoMaintenanceScreen(delegate: self)
    }
}
