//
//  TenantComplaintDetailViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/13/24.
//

import Foundation

class TenantComplaintDetailViewModel {
    var errorMessage: Observable<String> = Observable("")
    var complaintDetail: Observable<TenantComplaintDetail> = Observable(nil)
    var confirm: Observable<ConfirmModel> = Observable(nil)

    var parameters: [String: Any]?
    
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
    
    func confirm(complaintID: Int){
        _ = URLSession.shared.request(route: .tenantConfirmation, method: .post, parameters: ["id": complaintID], model: ConfirmModel.self) { result in
            switch result {
            case .success(let confirm):
                self.confirm.value = confirm
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getProperty() -> String? {
        let type = self.complaintDetail.value?.property?.buildingType?.capitalized
        
        let buildingNo = self.complaintDetail.value?.property?.buildingNo
        let district = self.complaintDetail.value?.property?.district
        let city = self.complaintDetail.value?.property?.city

        return "\(type ?? "" ) \(buildingNo ?? ""), \(district ?? ""), \(city ?? "")"
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
    
    func getStatus() -> String {
        let status = Helper.shared.getComplaintStatus(ownerApproval: self.complaintDetail.value?.ownerApproval, companyApproval: self.complaintDetail.value?.companyApproval, taskComplete: self.complaintDetail.value?.taskComplete, tenantApproval: self.complaintDetail.value?.tenantApproval, workerID: ((self.complaintDetail.value?.workerID) != nil) ? 1 : 0)
        return status.0
    }
    
    func getCompanyUploadedPhotos() -> [ComplainImage] {
        print(self.complaintDetail.value?.completionImages ?? [])
        return self.complaintDetail.value?.completionImages ?? []
    }
    
    func getTenantName() -> String {
        let name = self.complaintDetail.value?.tenant?.name ?? ""
        let contact = self.complaintDetail.value?.tenant?.contact ?? ""
        
        return "\(name) - \(contact)"
    }
    
    func getPostedDate() -> String {
        return Helper.shared.dateFormate(dateString: self.complaintDetail.value?.timestamp ?? "")
    }
    
    func getAcceptedDate() -> String {
        return Helper.shared.dateFormate(dateString: self.complaintDetail.value?.companyApprovalDatetime ?? "")
    }
    
    func getPhotosCount() -> Int {
        print(self.complaintDetail.value?.complainImages?.count ?? 0)
        return self.complaintDetail.value?.complainImages?.count ?? 0
    }
    
    func getPhotosForCompletedCount() -> Int {
        return self.complaintDetail.value?.completionImages?.count ?? 0
    }
    
    func getPhotosForInProgressComplaint() -> [ComplainImage] {
        return self.complaintDetail.value?.complainImages ?? []
    }
    
    func getPhotoForCompletedComplaint() -> [ComplainImage] {
        return self.complaintDetail.value?.completionImages ?? []
    }
    
    func getPhoto(index: Int) -> String {
        print(self.complaintDetail.value?.complainImages?[index].imageURL ?? "")
        return self.complaintDetail.value?.complainImages?[index].imageURL ?? ""
    }
    
    func getPhotoForCompleted(index: Int) -> String {
        print(self.complaintDetail.value?.completionImages?[index].imageURL ?? "")
        return self.complaintDetail.value?.completionImages?[index].imageURL ?? ""
    }
    
    func getAllComplaintPhoto() -> [ComplainImage] {
        return self.complaintDetail.value?.complainImages ?? []
    }
    
    func getAllCompletedPhoto() -> [ComplainImage] {
        return self.complaintDetail.value?.completionImages ?? []
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
    
    func isConfirmBYTenant() -> Int{
        return self.complaintDetail.value?.tenantApproval ?? 0
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
        let contact = self.complaintDetail.value?.property?.company?.contact ?? ""
        return contact
    }
        
    func hideScheduleView() -> Bool {
        let workerID = self.complaintDetail.value?.workerID ?? 0

        if workerID == 0{
            return true
        }
        else {
            return false
        }
    }
    
    func hideConfirmView() -> Bool {
        let workerID = self.complaintDetail.value?.workerID ?? 0
        let isTaskCompleted = self.complaintDetail.value?.taskComplete ?? 0
        let isConfirmBYTenant = self.complaintDetail.value?.tenantApproval ?? 0

        if workerID == 0 && isTaskCompleted == 0 && isConfirmBYTenant == 0{
            return true
        }
        else if workerID != 0 && isTaskCompleted == 1 && isConfirmBYTenant == 1{
            return true
        }
        else if isTaskCompleted != 1{
            return true
        }
        else {
            return false
        }
    }
    
    func hideCompanyContactView() -> Bool {
        let isTaskCompleted = self.complaintDetail.value?.companyApproval ?? 0
        return isTaskCompleted == 1 ? false : true
    }
    
    func hideComplaintPhotoView() -> Bool {
        let isConfirmBYTenant = self.complaintDetail.value?.tenantApproval ?? 0
        return isConfirmBYTenant == 1 ? true : false
    }
    
    func hideCompanyPhotoView() -> Bool {
        let isTaskCompleted = self.complaintDetail.value?.taskComplete ?? 0
        return isTaskCompleted == 0 ? true : false
    }
    
    func getAssignWorkerContact() -> String {
       let contact = self.complaintDetail.value?.worker?.contact ?? ""
        let name = self.complaintDetail.value?.worker?.name ?? ""
        return "\(name) (\(contact))"
    }
    
    func showMore() -> Bool {
        let workerID = self.complaintDetail.value?.workerID ?? 0
        let isTaskCompleted = self.complaintDetail.value?.taskComplete ?? 0
        let isConfirmBYTenant = self.complaintDetail.value?.tenantApproval ?? 0
        if isTaskCompleted == 1 && isConfirmBYTenant == 0{
            return false
        }
        else if isTaskCompleted == 1 && isConfirmBYTenant == 1{
            return false
        }
        else if workerID == 1{
            return false
        }
        else{
            return true
        }
    }
    
    func hideCompletedView() -> Bool {
        let isTaskCompleted = self.complaintDetail.value?.taskComplete ?? 0
        return isTaskCompleted == 1 ? false : true
    }
    
    func getCompletedDate() -> String {
        return Helper.shared.dateFormate(dateString: self.complaintDetail.value?.taskCompleteDatetime ?? "")
    }
    
    func hideApproveView() -> Bool {
        let isApproved = self.complaintDetail.value?.ownerApproval ?? 0
        return isApproved == 1 ? false : true
    }
    
    func getApprovedDate() -> String {
        return Helper.shared.dateFormate(dateString: self.complaintDetail.value?.ownerApprovalDatetime ?? "")
    }
    
    func hideAcceptedView() -> Bool {
        let isApproved = self.complaintDetail.value?.companyApproval ?? 0
        return isApproved == 1 ? false : true
    }
    
//    func getAcceptedDate() -> String {
//        return Helper.shared.dateFormate(dateString: self.complaintDetail.value?.companyApprovalDatetime ?? "")
//    }
}
