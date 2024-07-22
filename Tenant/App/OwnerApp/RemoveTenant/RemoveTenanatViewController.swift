//
//  RemoveFlatViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/18/24.
//

import UIKit

class RemoveTenanatViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var contactLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.setImage(UIImage(named: Helper.shared.isRTL() ? "back-arrow-ar" : "back-arrow-en"), for: .normal)
        deleteButton.setTitle(LocalizationKeys.deleteTenant.rawValue.localizeString(), for: .normal)
        contactLabel.text = LocalizationKeys.contact.rawValue.localizeString()

    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
