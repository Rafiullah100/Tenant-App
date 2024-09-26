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
    var propertyDetail: PropertiesRow?
    @IBOutlet weak var assignButton: UIButton!
    var viewModel: DeleteTenantViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let property = propertyDetail else { return }
        viewModel = DeleteTenantViewModel(propertyDetail: property)
        
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
                    UserDefaults.standard.ownerTotolTenants = (UserDefaults.standard.ownerTotolTenants ?? 1) - 1
                    NotificationCenter.default.post(name: Notification.Name(Constants.reloadProperties), object: nil)
                    ToastManager.shared.showToast(message: delete.message ?? "")
                    self.navigationController?.popViewController(animated: true)
                }
                else{
                    ToastManager.shared.showToast(message: delete.message ?? "")
                }
            }
        }
    }
    
    private func updateUI(){
        buidlingTypeNameLabel.text = viewModel.getPropertyType()
        flatMngmtView.isHidden = viewModel.hideFlatView()
        tenantMngmtView.isHidden = viewModel.hideTenantManagmentView()
        villaTenantMangmtView.isHidden = viewModel.hideVillaTenantView()
        companyNameValueLabel.text = viewModel.getCompany()
        flatValueLabel.text = "\(viewModel.getNumberOfFLat())"
        nameLabel.text = viewModel.getAddress()
        
        if viewModel.isPropertyVilla() {
            tenantView.isHidden = viewModel.isVillaTenantExist()
            if tenantView.isHidden == false{
                tenantNameLabel.text = viewModel.getVillaTenantName()
                tenantContactLabel.text = viewModel.getVillaTenantContact()
                assignButton.isUserInteractionEnabled = false
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func flatBtnAction(_ sender: Any) {
        Switcher.gotoFlatList(delegate: self, propertyID: viewModel.getPropertyID(), property: nameLabel.text ?? "")
    }
    
    @IBAction func tenantMngMentAction(_ sender: Any) {
        Switcher.gotoTenantList(delegate: self, propertyID: viewModel.getPropertyID(), property: nameLabel.text ?? "")
    }
    @IBAction func companyBtnAction(_ sender: Any) {
        Switcher.gotoCompanyList(delegate: self, propertyID: viewModel.getPropertyID(), property: nameLabel.text ?? "")
    }
    
    @IBAction func deleteBtnAction(_ sender: Any) {
        self.animateSpinner()
        viewModel.deleteTenant(flatID: viewModel.getVillaFlatID())
    }
    
    @IBAction func assigntenantToVilla(_ sender: Any) {
//        let flatsCount = propertyDetail?.flats?.count ?? 0
//        guard flatsCount > 0 else { return  }
        Switcher.gotoAddTenant(delegate: self, flatID: viewModel.getVillaFlatID(), flatNumber: viewModel.getVillaFlatNNumber())
    }
}
