//
//  AddTenanToFlatViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/18/24.
//

import UIKit

class AddTenanToFlatViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var assignButton: UIButton!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setImage(UIImage(named: Helper.shared.isRTL() ? "back-arrow-ar" : "back-arrow-en"), for: .normal)
        titleLabel.text = LocalizationKeys.addTenantToFlat.rawValue.localizeString()
        nameLabel.text = LocalizationKeys.tenantName.rawValue.localizeString()
        contactLabel.text = LocalizationKeys.addtenantContactNumber.rawValue.localizeString()
        
        nameTextField.placeholder = LocalizationKeys.enterTenantName.rawValue.localizeString()
        nameTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        contactTextField.placeholder = LocalizationKeys.addtenantContactNumber.rawValue.localizeString()
        contactTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        assignButton.setTitle(LocalizationKeys.assignTenantToFlat.rawValue.localizeString(), for: .normal)
    }
    

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
