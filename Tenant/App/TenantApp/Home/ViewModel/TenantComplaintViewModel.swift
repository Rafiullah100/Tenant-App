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
    
    //for history
//    func isTaskCompleted(index: Int) -> Int {
//        return self.complaintList.value?.complaintsRecent?.rows?[index].taskComplete ?? 0
//    }
    
}
