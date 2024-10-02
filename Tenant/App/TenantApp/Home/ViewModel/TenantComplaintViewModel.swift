//
//  TenantComplaintViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/12/24.
//

import Foundation

class TenantComplaintViewModel {
    var errorMessage: Observable<String> = Observable("")
    var complaintList: Observable<TenantComplaintModel> = Observable(nil)
    var tenantResidence: Observable<TenantResidenceModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func getComplaints(){
        _ = URLSession.shared.request(route: .getComplaints, method: .post, parameters: [:], model: TenantComplaintModel.self) { result in
            switch result {
            case .success(let list):
                self.complaintList.value = list
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getTenantResidence(){
        _ = URLSession.shared.request(route: .getTenantResidence, method: .post, parameters: ["tenant_id": UserDefaults.standard.userID ?? 0], model: TenantResidenceModel.self) { result in
            switch result {
            case .success(let residence):
                self.tenantResidence.value = residence
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func propertyIDIfTenant() -> Int{
        return self.tenantResidence.value?.flat?.properties?.id ?? 0
    }
    
    func flatIDIfTenant() -> Int{
        return self.tenantResidence.value?.flat?.id ?? 0
    }
    
    func isPropertyAssigned() -> Bool{
        let propertyID = self.tenantResidence.value?.flat?.properties?.id ?? 0
        let flatID = self.tenantResidence.value?.flat?.id ?? 0
        if propertyID == 0 || flatID == 0{
            return false
        }
        else{
            return true
        }
    }
    
    func isCompanyAssigned() -> Bool{
        return self.tenantResidence.value?.flat?.properties?.companyID ?? 0 == 0 ? false : true
    }
    
    func getTenantFlatNo() -> String {
        print(self.tenantResidence.value?.flat?.flatNo ?? "")
        return self.tenantResidence.value?.flat?.flatNo ?? ""
    }
    
    func getTenantBuildingNo() -> String {
        return self.tenantResidence.value?.flat?.properties?.buildingNo ?? ""
    }
    
    func isVilla() -> Bool {
       let type = self.tenantResidence.value?.flat?.properties?.buildingType ?? ""
        if type == "villa"{
            return true
        }
        else{
            return false
        }
    }
    
    func getBuildingType() -> String {
        return "\(self.tenantResidence.value?.flat?.properties?.buildingType?.capitalized ?? ""):"
    }
    
    func getBuilding() -> String {
        let title = self.tenantResidence.value?.flat?.properties?.title ?? ""
        let type = self.tenantResidence.value?.flat?.properties?.buildingType ?? ""
        let buildingNumber = self.tenantResidence.value?.flat?.properties?.buildingNo ?? ""
        let buildingDistrict = self.tenantResidence.value?.flat?.properties?.district ?? ""
        let buildingCity = self.tenantResidence.value?.flat?.properties?.city ?? ""
        return "\(title), \(type) \(buildingNumber), \(buildingDistrict), \(buildingCity)"
    }
    
    func getRecentID(index: Int) -> Int{
        return self.complaintList.value?.complaintsRecent?.rows?[index].id ?? 0
    }
    
    func getHistoryID(index: Int) -> Int{
        return self.complaintList.value?.complaintsHistory?.rows?[index].id ?? 0
    }

    func getRecentCount() -> Int {
        return self.complaintList.value?.complaintsRecent?.rows?.count ?? 0
    }
    
    func getHistoryCount() -> Int {
        return self.complaintList.value?.complaintsHistory?.rows?.count ?? 0
    }
    
    func getRecentComplaint(index: Int) -> TenantComplaintsRow? {
        guard let complaint = self.complaintList.value?.complaintsRecent?.rows?[index] else { return nil }
        return complaint
    }
    
    func getHistoryComplaint(index: Int) -> TenantComplaintsRow? {
        guard let complaint = self.complaintList.value?.complaintsHistory?.rows?[index] else { return nil }
        return complaint
    }
    
    func isTaskCompleted(index: Int) -> Int {
        return self.complaintList.value?.complaintsRecent?.rows?[index].taskComplete ?? 0
    }
    
    func isConfirmed(index: Int) -> Int {
        return self.complaintList.value?.complaintsRecent?.rows?[index].tenantApproval ?? 0
    }
    
    //for history
//    func isTaskCompleted(index: Int) -> Int {
//        return self.complaintList.value?.complaintsRecent?.rows?[index].taskComplete ?? 0
//    }
    
    
    func isHomeButtonHide() -> Bool {
                guard UserDefaults.standard.propertyIDIfTenant == 0 && UserDefaults.standard.flatIDIfTenant == 0 || UserDefaults.standard.propertyIDIfTenant == nil && UserDefaults.standard.flatIDIfTenant == nil else{
                    return true
                }
        return false
    }
}
