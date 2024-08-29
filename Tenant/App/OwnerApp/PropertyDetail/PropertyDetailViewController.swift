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
    
    @IBOutlet weak var tenantView: UIView!
    @IBOutlet weak var tenantContactLabel: UILabel!
    @IBOutlet weak var tenantNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flatValueLabel: UILabel!
    @IBOutlet weak var companyNameValueLabel: UILabel!
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
    var propertyDetail: PropertiesRow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flatManagmentButton.setTitle(LocalizationKeys.flatManagement.rawValue.localizeString(), for: .normal)
        tenantMangementButton.setTitle(LocalizationKeys.tenantManagement.rawValue.localizeString(), for: .normal)
        companyButton.setTitle(LocalizationKeys.maintainanceCompanyManagement.rawValue.localizeString(), for: .normal)
        typeLabel.text = LocalizationKeys.type.rawValue.localizeString()
        flatLabel.text = LocalizationKeys.totalFlats.rawValue.localizeString()
        maintainLabel.text = LocalizationKeys.maintainedBy.rawValue.localizeString()
        titlLabel.text = LocalizationKeys.managements.rawValue.localizeString()
        type = .company
        
        updateUI()
    }
    
    private func updateUI(){
        propertyType = propertyDetail?.buildingType == "building" ? .building : .villa
        propertyID = propertyDetail?.id
        buidlingTypeNameLabel.text = propertyType == .building ? "Building" : "Villa"
        flatMngmtView.isHidden = propertyType == .building ? false : true
        tenantMngmtView.isHidden = propertyType == .building ? false : true
        villaTenantMangmtView.isHidden = propertyType == .villa ? false : true
        companyNameValueLabel.text = propertyDetail?.company?.name ?? "Not assigned to Company"
        flatValueLabel.text = "\(propertyDetail?.flats?.count ?? 0)"
        
        nameLabel.text = "\(propertyDetail?.buildingType?.capitalized ?? "") \(propertyDetail?.buildingNo ?? ""), \(propertyDetail?.district ?? ""), \(propertyDetail?.city ?? "")"
        if propertyType == .villa {
            let flatsCount = propertyDetail?.flats?.count ?? 0
            tenantView.isHidden = flatsCount == 0 ? true : false
            if flatsCount > 0{
                tenantView.isHidden = ((propertyDetail?.flats?.first?.tenantID) != nil) ? false : true
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func flatBtnAction(_ sender: Any) {
        Switcher.gotoFlatList(delegate: self, propertyID: propertyID ?? 0)
    }
    
    @IBAction func companyBtnAction(_ sender: Any) {
        Switcher.gotoCompanyList(delegate: self, propertyID: propertyID ?? 0)
    }
    
    @IBAction func assigntenantToVilla(_ sender: Any) {
    }
}
