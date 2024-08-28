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
    
    @IBOutlet weak var tenantMngmtView: UIView!
    @IBOutlet weak var flatMngmtView: UIView!
    @IBOutlet weak var companyButton: UIButton!
    @IBOutlet weak var tenantMangementButton: UIButton!
    @IBOutlet weak var titlLabel: UILabel!
    @IBOutlet weak var flatLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var buidlingTypeNameLabel: UILabel!
    
    @IBOutlet weak var villaTenantMangmtView: UIView!
    var propertyType: PropertyType?
    var propertyID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flatManagmentButton.setTitle(LocalizationKeys.flatManagement.rawValue.localizeString(), for: .normal)
        tenantMangementButton.setTitle(LocalizationKeys.tenantManagement.rawValue.localizeString(), for: .normal)
        companyButton.setTitle(LocalizationKeys.maintainanceCompanyManagement.rawValue.localizeString(), for: .normal)
        typeLabel.text = LocalizationKeys.type.rawValue.localizeString()
        flatLabel.text = LocalizationKeys.totalFlats.rawValue.localizeString()
        maintainLabel.text = LocalizationKeys.maintainedBy.rawValue.localizeString()
        titlLabel.text = LocalizationKeys.managements.rawValue.localizeString()
        buidlingTypeNameLabel.text = propertyType == .building ? "Building" : "Villa"
        flatMngmtView.isHidden = propertyType == .building ? false : true
        tenantMngmtView.isHidden = propertyType == .building ? false : true
        villaTenantMangmtView.isHidden = propertyType == .villa ? false : true

        type = .company
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func companyBtnAction(_ sender: Any) {
        Switcher.gotoCompanyList(delegate: self, propertyID: propertyID ?? 0)
    }
}
