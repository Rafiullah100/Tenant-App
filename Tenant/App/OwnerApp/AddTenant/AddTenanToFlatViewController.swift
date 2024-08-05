//
//  AddTenanToFlatViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/18/24.
//

import UIKit

class AddTenanToFlatViewController: BaseViewController {

    @IBOutlet weak var assignButton: UIButton!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titlLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titlLabel.text = LocalizationKeys.addTenantToFlat.rawValue.localizeString()
        nameLabel.text = LocalizationKeys.tenantName.rawValue.localizeString()
        contactLabel.text = LocalizationKeys.addtenantContactNumber.rawValue.localizeString()
        
        nameTextField.placeholder = LocalizationKeys.enterTenantName.rawValue.localizeString()
        nameTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        contactTextField.placeholder = LocalizationKeys.addtenantContactNumber.rawValue.localizeString()
        contactTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
        assignButton.setTitle(LocalizationKeys.assignTenantToFlat.rawValue.localizeString(), for: .normal)
        type = .company
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

}
