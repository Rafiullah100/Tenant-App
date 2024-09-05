//
//  OwnerDetailViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/26/24.
//

import Foundation

//
//  CompanyPendingViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/23/24.
//

import Foundation


class OwnerDetailViewModel {
    var errorMessage: Observable<String> = Observable("")
    var complaintDetail: Observable<TenantComplaintDetail> = Observable(nil)
    var approve: Observable<ApproveModel> = Observable(nil)

    func getComplaints(complaintID: Int){
        _ = URLSession.shared.request(route: .getComplaintDetail, method: .post, parameters: ["id": complaintID], model: TenantComplaintDetailModel.self) { result in
            switch result {
            case .success(let details):
                self.complaintDetail.value = details.complaintDetail
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func changeStatus(complaintID: Int, action: String){
        _ = URLSession.shared.request(route: .ownerApproval, method: .post, parameters: ["id": complaintID, "action": action], model: ApproveModel.self) { result in
            switch result {
            case .success(let approve):
                self.approve.value = approve
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getTitle() -> String {
        return self.complaintDetail.value?.title ?? ""
    }
    
    func getDescription() -> String {
        return self.complaintDetail.value?.description ?? ""
    }
    
    func getCompalintID() -> Int {
        return self.complaintDetail.value?.id ?? 0
    }
    
    func getStatus() -> String {
        let status = Helper.shared.getComplaintStatus(ownerApproval: self.complaintDetail.value?.ownerApproval, companyApproval: self.complaintDetail.value?.companyApproval, taskComplete: self.complaintDetail.value?.taskComplete, tenantApproval: self.complaintDetail.value?.tenantApproval, workerID: ((self.complaintDetail.value?.workerID) != nil) ? 1 : 0)
        return status.0
    }
    
    func getCompanyUploadedPhotos() -> [ComplainImage] {
        print(self.complaintDetail.value?.completionImages ?? [])
        return self.complaintDetail.value?.completionImages ?? []
    }
    
    func getPostedDate() -> String {
        return Helper.shared.dateFormate(dateString: self.complaintDetail.value?.timestamp ?? "")
    }
    
    func getPhotosForInProgressComplaint() -> [ComplainImage] {
        return self.complaintDetail.value?.complainImages ?? []
    }
    
    func getTenantPhotoCount() -> Int {
        return self.complaintDetail.value?.complainImages?.count ?? 0
    }
    
    func getCompanyPhotoCount() -> Int {
        return self.complaintDetail.value?.completionImages?.count ?? 0
    }
    
    func getTenantPhoto(index: Int) -> String {
        print(self.complaintDetail.value?.complainImages?[index].imageURL ?? "")
        return self.complaintDetail.value?.complainImages?[index].imageURL ?? ""
    }
    
    func getCompanyPhoto(index: Int) -> String {
        return self.complaintDetail.value?.completionImages?[index].imageURL ?? ""
    }
    
    func getWorkerID() -> Int {
        return self.complaintDetail.value?.workerID ?? 0
    }
    
    func isTaskCompleted() -> Int {
        return self.complaintDetail.value?.taskComplete ?? 0
    }
    
    func getScheduleDate() -> String {
//        return self.complaintDetail.value?.scheduleDate ?? ""
        return Helper.shared.dateFormate(dateString: self.complaintDetail.value?.scheduleDate ?? "")
    }
    
    func getScheduleTime() -> String {
//        return self.complaintDetail.value?.scheduleTime ?? ""
        return Helper.shared.dateFormate(dateString: self.complaintDetail.value?.scheduleTime ?? "")

    }
    
    func getMaintenancePersonContact() -> String {
        return self.complaintDetail.value?.property?.company?.contact ?? ""
    }
    
    func getCompanyAcceptedDate() -> String {
//        return self.complaintDetail.value?.companyApprovalDatetime ?? ""
        return Helper.shared.dateFormate(dateString: self.complaintDetail.value?.companyApprovalDatetime ?? "")
    }
    
    func getOwnerApprovalDate() -> String {
//        return self.complaintDetail.value?.ownerApprovalDatetime ?? ""
        return Helper.shared.dateFormate(dateString: self.complaintDetail.value?.ownerApprovalDatetime ?? "")
    }
    
    func isRejected() -> Bool {
        if self.complaintDetail.value?.ownerApproval == 2{
            return true
        }
        else {
            return false
        }
    }
    
    func getContacts() -> String? {
        let company = self.complaintDetail.value?.property?.company?.contact ?? ""
        let person = self.complaintDetail.value?.property?.company?.contact ?? ""

        return company + " | " + person
    }
    
    func getTenant() -> String {
        let name = self.complaintDetail.value?.tenant?.name ?? ""
        let contact = self.complaintDetail.value?.tenant?.contact ?? ""
        
        return "\(name) - \(contact)"
    }
}
