//
//  DeleteTenantViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/29/24.
//

import Foundation

class DeleteTenantViewModel {
    var errorMessage: Observable<String> = Observable("")
    var delete: Observable<DeleteTenantModel> = Observable(nil)
    private var property: PropertiesRow?
    init(propertyDetail: PropertiesRow? = nil) {
        self.property = propertyDetail
    }
    
    func deleteTenant(flatID: Int){
        _ = URLSession.shared.request(route: .deleteTenantFromFlat, method: .post, parameters: ["flat_id": flatID], model: DeleteTenantModel.self) { result in
            switch result {
            case .success(let list):
                self.delete.value = list
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getPropertyID() -> Int {
        return property?.id ?? 0
    }
    
    func getPropertyType() -> String{
        return property?.buildingType?.capitalized ?? ""
    }
    
    func hideFlatView() -> Bool {
        return property?.buildingType == "building" ? false : true
    }
    
    func hideTenantManagmentView() -> Bool {
        return property?.buildingType == "building" ? false : true
    }
    
    func hideVillaTenantView() -> Bool {
        return property?.buildingType == "villa" ? false : true
    }
    
    func getCompany() -> String {
        return property?.company?.name ?? LocalizationKeys.notAssignedToCompany.rawValue.localizeString()
    }
    
    func getNumberOfFLat() -> Int {
        return property?.flats?.count ?? 0
    }
    
    func getAddress() -> String {
        return "\(property?.title?.capitalized ?? ""), \(property?.buildingType?.capitalized ?? "") \(property?.buildingNo ?? ""), \(property?.district ?? ""), \(property?.city ?? "")"
    }
    
    func isPropertyVilla() -> Bool {
        return property?.buildingType == "villa" ? true : false
    }
    
    func isVillaTenantExist() -> Bool {
        return property?.flats?.first?.tenantID == nil ? true : false
    }
    
    func getVillaTenantName() -> String {
        return property?.flats?[0].ownersTenants?.name ?? ""
    }
    
    func getVillaTenantContact() -> String {
        return property?.flats?[0].ownersTenants?.contact ?? ""
    }
    
    func getVillaFlatID() -> Int {
        return property?.flats?[0].id ?? 0
    }
    
    func getVillaFlatNNumber() -> String {
        return property?.flats?[0].flatNo ?? ""
    }
    
//    propertyType = propertyDetail?.buildingType == "building" ? .building : .villa
//    propertyID = propertyDetail?.id
//    buidlingTypeNameLabel.text = propertyType == .building ? "Building" : "Villa"
//    flatMngmtView.isHidden = propertyType == .building ? false : true
//    tenantMngmtView.isHidden = propertyType == .building ? false : true
//    villaTenantMangmtView.isHidden = propertyType == .villa ? false : true
//    companyNameValueLabel.text = propertyDetail?.company?.name ?? "Not assigned to Company"
//    flatValueLabel.text = "\(propertyDetail?.flats?.count ?? 0)"

}
