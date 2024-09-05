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
    @IBOutlet weak var assignButton: UIButton!
    let viewModel = DeleteTenantViewModel()

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
        
        viewModel.delete.bind { delete in
            DispatchQueue.main.async {
                guard let delete = delete else{return}
                self.stopAnimation()
                if delete.success == true{
                    self.showAlertWithbutttons(message: delete.message ?? "") {
                        NotificationCenter.default.post(name: Notification.Name(Constants.reloadProperties), object: nil)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                else{
                    self.showAlert(message: delete.message ?? "")
                }
            }
        }
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
                if tenantView.isHidden == false{
                    tenantNameLabel.text = propertyDetail?.flats?[0].ownersTenants?.name ?? ""
                    tenantContactLabel.text = propertyDetail?.flats?[0].ownersTenants?.contact ?? ""
                    assignButton.isUserInteractionEnabled = false
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func flatBtnAction(_ sender: Any) {
        Switcher.gotoFlatList(delegate: self, propertyID: propertyID ?? 0, buildingNumber: propertyDetail?.buildingNo ?? "")
    }
    
    @IBAction func companyBtnAction(_ sender: Any) {
        Switcher.gotoCompanyList(delegate: self, propertyID: propertyID ?? 0, buildingNumber: propertyDetail?.buildingNo ?? "")
    }
    
    @IBAction func deleteBtnAction(_ sender: Any) {
        self.animateSpinner()
        viewModel.deleteTenant(flatID: propertyDetail?.flats?[0].id ?? 0)
    }
    
    @IBAction func assigntenantToVilla(_ sender: Any) {
        let flatsCount = propertyDetail?.flats?.count ?? 0
        guard flatsCount > 0 else { return  }
        Switcher.gotoAddTenant(delegate: self, flatID: propertyDetail?.flats?[0].id ?? 0, flatNumber: propertyDetail?.flats?[0].flatNo ?? "")
    }
}
