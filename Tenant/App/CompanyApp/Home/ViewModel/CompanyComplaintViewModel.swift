//
//  ViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/20/24.
//

import Foundation

class CompanyComplaintViewModel {
    var errorMessage: Observable<String> = Observable("")
    var complaintList: Observable<CompanyComplaintsModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func getComplaints(search: String){
        _ = URLSession.shared.request(route: .getCompanyComplaints, method: .post, parameters: ["search": search], model: CompanyComplaintsModel.self) { result in
            switch result {
            case .success(let list):
                self.complaintList.value = list
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getRecentID(index: Int) -> Int{
        return self.complaintList.value?.complaintsRecent?.rows?[index].id ?? 0
    }
    
    func getOngoingID(index: Int) -> Int{
        return self.complaintList.value?.complaintsOngoing?.rows?[index].id ?? 0
    }
    
    func getHistoryID(index: Int) -> Int{
        return self.complaintList.value?.complaintsHistory?.rows?[index].id ?? 0
    }

    func getRecentCount() -> Int {
        return self.complaintList.value?.complaintsRecent?.rows?.count ?? 0
    }
    
    func getOngoingCount() -> Int {
        return self.complaintList.value?.complaintsOngoing?.rows?.count ?? 0
    }
    
    func getHistoryCount() -> Int {
        return self.complaintList.value?.complaintsHistory?.rows?.count ?? 0
    }
    
    func getRecentComplaint(index: Int) -> CompanyComplaintsRow? {
        guard let complaint = self.complaintList.value?.complaintsRecent?.rows?[index] else { return nil }
        return complaint
    }
    
    func getOngoingComplaint(index: Int) -> CompanyComplaintsRow? {
        guard let complaint = self.complaintList.value?.complaintsOngoing?.rows?[index] else { return nil }
        return complaint
    }
    
    func getHistoryComplaint(index: Int) -> CompanyComplaintsRow? {
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
