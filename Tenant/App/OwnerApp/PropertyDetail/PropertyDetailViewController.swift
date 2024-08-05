//
//  PropertyDetailViewController.swift
//  Tenant
//
//  Created by MacBook Pro on 7/12/24.
//

import UIKit

class PropertyDetailViewController: BaseViewController {
    @IBOutlet weak var maintainLabel: UILabel!
    @IBOutlet weak var flatManagmentButton: UIButton!
    
    @IBOutlet weak var companyButton: UIButton!
    @IBOutlet weak var tenantMangementButton: UIButton!
    @IBOutlet weak var titlLabel: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        flatManagmentButton.setTitle(LocalizationKeys.flatManagement.rawValue.localizeString(), for: .normal)
        tenantMangementButton.setTitle(LocalizationKeys.tenantManagement.rawValue.localizeString(), for: .normal)
        companyButton.setTitle(LocalizationKeys.maintainanceCompanyManagement.rawValue.localizeString(), for: .normal)
        typeLabel.text = LocalizationKeys.type.rawValue.localizeString()
        flatLabel.text = LocalizationKeys.totalFlats.rawValue.localizeString()
        maintainLabel.text = LocalizationKeys.maintainedBy.rawValue.localizeString()
        titlLabel.text = LocalizationKeys.managements.rawValue.localizeString()
        
        flatLabel.text = LocalizationKeys.flats.rawValue.localizeString() + "   25"
        typeLabel.text = LocalizationKeys.properties.rawValue.localizeString() + "   Building"
        
        type = .company
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
