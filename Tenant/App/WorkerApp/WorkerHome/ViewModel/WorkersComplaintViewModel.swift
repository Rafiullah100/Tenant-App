//
//  WorkersViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/27/24.
//

import Foundation

class WorkersComplaintViewModel {
    var errorMessage: Observable<String> = Observable("")
    var complaintList: Observable<WorkersComplaintsModel> = Observable(nil)
    
    var parameters: [String: Any]?
    
    func getComplaints(){
        _ = URLSession.shared.request(route: .workerComplaints, method: .post, parameters: [:], model: WorkersComplaintsModel.self) { result in
            switch result {
            case .success(let list):
                self.complaintList.value = list
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getRecentComplaintID(at index: Int) -> Int {
        return self.complaintList.value?.complaintsRecent?.rows?[index].id ?? 0
    }
    
    func getCompletedComplaintID(at index: Int) -> Int {
        return self.complaintList.value?.complaintsHistory?.rows?[index].id ?? 0
    }
    
    func getRecentCount() -> Int {
        return self.complaintList.value?.complaintsRecent?.rows?.count ?? 0
    }
    
    func getCompletedCount() -> Int {
        return self.complaintList.value?.complaintsHistory?.rows?.count ?? 0
    }
    
    func getRecentComplaint(index: Int) -> WorkersRow? {
        guard let complaint = self.complaintList.value?.complaintsRecent?.rows?[index] else { return nil }
        return complaint
    }
    
    func getCompletedComplaint(index: Int) -> WorkersRow? {
        guard let complaint = self.complaintList.value?.complaintsHistory?.rows?[index] else { return nil }
        return complaint
    }
    
}
