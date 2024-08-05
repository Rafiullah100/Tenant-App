//
//  RemoveFlatViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/18/24.
//

import UIKit

class RemoveTenanatViewController: BaseViewController {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var contactLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteButton.setTitle(LocalizationKeys.deleteTenant.rawValue.localizeString(), for: .normal)
        contactLabel.text = LocalizationKeys.contact.rawValue.localizeString()
        type = .company
        viewControllerTitle = "Flat 1001"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    

}
