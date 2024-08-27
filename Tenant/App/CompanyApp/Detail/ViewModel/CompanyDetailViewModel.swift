//
//  CompanyPendingViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/23/24.
//

import Foundation


class CompanyDetailViewModel {
    var errorMessage: Observable<String> = Observable("")
    var complaintDetail: Observable<TenantComplaintDetail> = Observable(nil)
    var reject: Observable<RejectModel> = Observable(nil)

    
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
    
    func reject(complaintID: Int){
        _ = URLSession.shared.request(route: .reject, method: .post, parameters: ["id": complaintID], model: RejectModel.self) { result in
            switch result {
            case .success(let reject):
                self.reject.value = reject
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getTitle() -> String {
        return self.complaintDetail.value?.title?.capitalized ?? ""
    }
    
    func getDescription() -> String {
        return self.complaintDetail.value?.description ?? ""
    }
    
    func getCompalintID() -> Int {
        return self.complaintDetail.value?.id ?? 0
    }
    
    func getProperty() -> String? {
        let type = self.complaintDetail.value?.property?.buildingType
        var propertyType = ""
        
        if type == "builidng" {
            propertyType = "Builidng"
        }
        else{
            propertyType = "Villa"
        }
        let buildingNo = self.complaintDetail.value?.property?.buildingNo
        let district = self.complaintDetail.value?.property?.district
        let city = self.complaintDetail.value?.property?.city

        return "\(propertyType ) \(buildingNo ?? ""), \(district ?? ""), \(city ?? "")"
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
    
    func getPhoto(index: Int) -> String {
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
        return self.complaintDetail.value?.scheduleDate ?? ""
    }
    
    func getScheduleTime() -> String {
        return self.complaintDetail.value?.scheduleTime ?? ""
    }
    
    func getMaintenancePersonContact() -> String {
        return self.complaintDetail.value?.property?.company?.contact ?? ""
    }
    
    func getContacts() -> String? {
        let company = self.complaintDetail.value?.property?.company?.contact ?? ""
        let person = self.complaintDetail.value?.property?.company?.contact ?? ""

        return company + " | " + person
    }
}
