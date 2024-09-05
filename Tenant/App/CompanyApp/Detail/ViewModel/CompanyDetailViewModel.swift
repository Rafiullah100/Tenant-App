//
//  CompanyPendingViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/23/24.
//

import Foundation


class CompanyDetailViewModel {
    var errorMessage: Observable<String> = Observable("")
    var complaintDetail: Observable<TenantComplaintDetailModel> = Observable(nil)
    var reject: Observable<RejectModel> = Observable(nil)

    
    func getComplaints(complaintID: Int){
        _ = URLSession.shared.request(route: .getComplaintDetail, method: .post, parameters: ["id": complaintID], model: TenantComplaintDetailModel.self) { result in
            switch result {
            case .success(let details):
                self.complaintDetail.value = details
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
    
    func getComplaint() -> TenantComplaintDetail? {
        return self.complaintDetail.value?.complaintDetail
    }
    
    func getTitle() -> String {
        return self.complaintDetail.value?.complaintDetail?.title?.capitalized ?? ""
    }
    
    func getDescription() -> String {
        return self.complaintDetail.value?.complaintDetail?.description ?? ""
    }
    
    func getCompalintID() -> Int {
        return self.complaintDetail.value?.complaintDetail?.id ?? 0
    }
    
    func getProperty() -> String? {
        let type = self.complaintDetail.value?.complaintDetail?.property?.buildingType
        var propertyType = ""
        
        if type == "builidng" {
            propertyType = "Builidng"
        }
        else{
            propertyType = "Villa"
        }
        let buildingNo = self.complaintDetail.value?.complaintDetail?.property?.buildingNo
        let district = self.complaintDetail.value?.complaintDetail?.property?.district
        let city = self.complaintDetail.value?.complaintDetail?.property?.city

        return "\(propertyType ) \(buildingNo ?? ""), \(district ?? ""), \(city ?? "")"
    }
    
    func getStatus() -> String {
        let status = Helper.shared.getComplaintStatus(ownerApproval: self.complaintDetail.value?.complaintDetail?.ownerApproval, companyApproval: self.complaintDetail.value?.complaintDetail?.companyApproval, taskComplete: self.complaintDetail.value?.complaintDetail?.taskComplete, tenantApproval: self.complaintDetail.value?.complaintDetail?.tenantApproval, workerID: ((self.complaintDetail.value?.complaintDetail?.workerID) != nil) ? 1 : 0)
        return status.0
    }
    
    func getCompanyUploadedPhotos() -> [ComplainImage] {
        print(self.complaintDetail.value?.complaintDetail?.completionImages ?? [])
        return self.complaintDetail.value?.complaintDetail?.completionImages ?? []
    }
    
    func getPostedDate() -> String {
        return Helper.shared.dateFormate(dateString: self.complaintDetail.value?.complaintDetail?.timestamp ?? "")
    }
    
    func getPhotosForInProgressComplaint() -> [ComplainImage] {
        return self.complaintDetail.value?.complaintDetail?.complainImages ?? []
    }
    
    func getPhoto(index: Int) -> String {
        print(self.complaintDetail.value?.complaintDetail?.complainImages?[index].imageURL ?? "")
        return self.complaintDetail.value?.complaintDetail?.complainImages?[index].imageURL ?? ""
    }
    
    func getCompanyPhoto(index: Int) -> String {
        return self.complaintDetail.value?.complaintDetail?.completionImages?[index].imageURL ?? ""
    }
    
    func getWorkerID() -> Int {
        return self.complaintDetail.value?.complaintDetail?.workerID ?? 0
    }
    
    func isTaskCompleted() -> Int {
        return self.complaintDetail.value?.complaintDetail?.taskComplete ?? 0
    }
    
    func getScheduleDate() -> String {
        return self.complaintDetail.value?.complaintDetail?.scheduleDate ?? ""
    }
    
    func getScheduleTime() -> String {
        return self.complaintDetail.value?.complaintDetail?.scheduleTime ?? ""
    }
    
    func getMaintenancePersonContact() -> String {
        return self.complaintDetail.value?.complaintDetail?.property?.company?.contact ?? ""
    }
    
    func getTenantNameContact() -> String {
        let name = self.complaintDetail.value?.complaintDetail?.tenant?.name ?? ""
        let contact = self.complaintDetail.value?.complaintDetail?.tenant?.contact ?? ""
        return "\(name) - \(contact)"
    }
    
    func getContacts() -> String? {
        let company = self.complaintDetail.value?.complaintDetail?.property?.company?.contact ?? ""
        let person = self.complaintDetail.value?.complaintDetail?.property?.company?.contact ?? ""

        return company + " | " + person
    }
}
