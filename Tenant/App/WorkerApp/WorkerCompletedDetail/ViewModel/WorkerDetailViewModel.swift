//
//  WorkerDetailViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/28/24.
//

import Foundation

//
//  TenantComplaintDetailViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/13/24.
//

import Foundation
import UIKit

class WorkerDetailViewModel {
    var errorMessage: Observable<String> = Observable("")
    var complaintDetail: Observable<TenantComplaintDetail> = Observable(nil)
    var completion: Observable<ConfirmModel> = Observable(nil)

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
    
    func markComplete(images: [UIImage], complaintID: Int)  {
        Networking.shared.markComplete(route: .workerCompletion, imageParameter: "images", images: images, parameters: ["id": complaintID]) { result in
            switch result {
            case .success(let completion):
                self.completion.value = completion
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getProperty() -> Property? {
        return self.complaintDetail.value?.property
    }
    
    func getAddress() -> NSAttributedString? {
        let title = self.complaintDetail.value?.property?.title?.capitalized
        let type = self.complaintDetail.value?.property?.buildingType?.capitalized
        
        let buildingNo = self.complaintDetail.value?.property?.buildingNo
        let district = self.complaintDetail.value?.property?.district
        let city = self.complaintDetail.value?.property?.city

        let address =  "\(title ?? "" ), \(type ?? "" ) \(buildingNo ?? ""), \(district ?? ""), \(city ?? "")"
        
        let attributedString = NSAttributedString(string: address, attributes: [
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        return attributedString
    }
    
    func getTenantName() -> String {
        let name = self.complaintDetail.value?.tenant?.name ?? ""
        let contact = self.complaintDetail.value?.tenant?.contact ?? ""
        
        return "\(name) - \(contact)"
    }
    
    func getAcceptedDate() -> String {
        return Helper.shared.dateFormate(dateString: self.complaintDetail.value?.companyApprovalDatetime ?? "")
    }
    
    func getPhotosCount() -> Int {
        return self.complaintDetail.value?.complainImages?.count ?? 0
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
    
    func getAllPhoto() -> [ComplainImage] {
        return self.complaintDetail.value?.complainImages ?? []
    }
    
    func getAllWorkerPhoto() -> [ComplainImage] {
        return self.complaintDetail.value?.completionImages ?? []
    }
    
    func getCompanyPhoto(index: Int) -> String {
        return self.complaintDetail.value?.completionImages?[index].imageURL ?? ""
    }
    
    func getCompanyPhotoCount() -> Int {
        return self.complaintDetail.value?.completionImages?.count ?? 0
    }
    
    func getWorkerID() -> Int {
        return self.complaintDetail.value?.workerID ?? 0
    }
    
    func isTaskCompleted() -> Int {
        return self.complaintDetail.value?.tenantApproval ?? 0
    }
    
    func getCompletedDate() -> String {
        return Helper.shared.dateFormate(dateString: self.complaintDetail.value?.tenantApprovalDatetime ?? "")
    }
    
    func getScheduleDate() -> String {
        return self.complaintDetail.value?.scheduleDate ?? ""
    }
    
    func getScheduleTime() -> String {
        return self.complaintDetail.value?.scheduleTime ?? ""
    }
    
    func getMaintenancePersonContact() -> String {
        let name = self.complaintDetail.value?.worker?.name
        let contact = self.complaintDetail.value?.worker?.contact
        return "\(name ?? "") (\(contact ?? ""))"
    }
    
    func getContacts() -> String? {
        let company = self.complaintDetail.value?.property?.company?.contact ?? ""
        let person = self.complaintDetail.value?.property?.company?.contact ?? ""

        return company + " | " + person
    }
    
    func hideCompletedView() -> Bool {
        return self.complaintDetail.value?.taskComplete == 1 ? true : false
    }
}
