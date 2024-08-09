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
    @IBOutlet weak var workerButton: UIButton!
    @IBOutlet weak var companyButton: UIButton!
    @IBOutlet weak var tenantButton: UIButton!
    @IBOutlet weak var ownerButton: UIButton!
    
    @IBOutlet var btnsView: [UIView]!
     var userType: UserType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        curveImageView.image = UIImage(named: Helper.shared.isRTL() ? "bg-ar" : "bg")
        signupLabel.text = LocalizationKeys.signup.rawValue.localizeString()
        chooseLabel.text = LocalizationKeys.chooseOne.rawValue.localizeString()
        continueButton.setTitle(LocalizationKeys.continuee.rawValue.localizeString(), for: .normal)
        
        ownerButton.setTitle(LocalizationKeys.owner.rawValue.localizeString(), for: .normal)
        tenantButton.setTitle(LocalizationKeys.tenantWithoutColon.rawValue.localizeString(), for: .normal)
        companyButton.setTitle(LocalizationKeys.company.rawValue.localizeString(), for: .normal)
        workerButton.setTitle(LocalizationKeys.workers.rawValue.localizeString(), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func ownerBtnAction(_ sender: Any) {
//        Switcher.gotoOwnerHome(delegate: self)
        selectButton(index: 0)
        userType = .owner
    }
    
    @IBAction func tenantBtnAction(_ sender: Any) {
//        Switcher.gotoTenantScreen(delegate: self)
        selectButton(index: 1)
        userType = .tenant
    }
    
    @IBAction func maintenanceBtnAction(_ sender: Any) {
//        Switcher.gotoCompanyScreen(delegate: self)
        selectButton(index: 2)
        userType = .company
    }
    
    @IBAction func workerBtnAction(_ sender: Any) {
//        Switcher.gotoWorkerScreen(delegate: self)
        selectButton(index: 3)
        userType = .worker
    }
    
    private func selectButton(index: Int){
        for i in 0..<btnsView.count{
            btnsView[i].backgroundColor = index == i ? CustomColor.buttonSelectedColor.color : CustomColor.buttonUnselectedColor.color
        }
    }
    
    @IBAction func continueBtnAction(_ sender: Any) {
        guard let userType = userType else {
            print("select user first")
            return
        }
        Switcher.gotoSigninScreen(delegate: self, userType: userType)
    }
}
