//
//  OwnerComplaintViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/26/24.
//

import Foundation


class OwnerComplaintViewModel {
    var errorMessage: Observable<String> = Observable("")
    var complaintList: Observable<OwnerComplaintModel> = Observable(nil)
    var profile: Observable<OwnerProfileModel> = Observable(nil)
    
    func getComplaints(search: String){
        _ = URLSession.shared.request(route: .ownerComplaints, method: .post, parameters: ["search": search], model: OwnerComplaintModel.self) { result in
            switch result {
            case .success(let list):
                self.complaintList.value = list
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getRecenttID(index: Int) -> Int{
        return self.complaintList.value?.complaintsRecent?.rows?[index].id ?? 0
    }
    
    func getOngoingID(index: Int) -> Int{
        return self.complaintList.value?.complaintsOngoing?.rows?[index].id ?? 0
    }
    
    func getRejectedID(index: Int) -> Int{
        return self.complaintList.value?.complaintsRejected?.rows?[index].id ?? 0
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
    
    func getRejectedCount() -> Int {
        return self.complaintList.value?.complaintsRejected?.rows?.count ?? 0
    }
    
    func getHistoryCount() -> Int {
        return self.complaintList.value?.complaintsHistory?.rows?.count ?? 0
    }
    
    func getRecentComplaint(index: Int) -> OwnerComplaintsRow? {
        guard let complaint = self.complaintList.value?.complaintsRecent?.rows?[index] else { return nil }
        return complaint
    }
    
    func getOngoingComplaint(index: Int) -> OwnerComplaintsRow? {
        guard let complaint = self.complaintList.value?.complaintsOngoing?.rows?[index] else { return nil }
        return complaint
    }
    
    func getRejectedComplaint(index: Int) -> OwnerComplaintsRow? {
        guard let complaint = self.complaintList.value?.complaintsRejected?.rows?[index] else { return nil }
        print(complaint)
        return complaint
    }
    
    func getHistoryComplaint(index: Int) -> OwnerComplaintsRow? {
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
    
    
    func getProfile(){
        _ = URLSession.shared.request(route: .ownerProfile, method: .post, parameters: ["id": UserDefaults.standard.userID ?? 0], model: OwnerProfileModel.self) { result in
            switch result {
            case .success(let profile):
                self.profile.value = profile
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getName() -> String {
        return profile.value?.ownerProfile?.name ?? "No Name"
    }
    
    func getPicture() -> String {
        return profile.value?.ownerProfile?.profileImage ?? ""
    }

    
    func getPropertiesCount() -> Int {
        return profile.value?.ownerProfile?.totalProperties ?? 0
    }
    
    func getTenantCount() -> Int {
        return profile.value?.ownerProfile?.totalTenant ?? 0
    }
    
    func getFlatCount() -> Int {
        return profile.value?.ownerProfile?.totalFlats ?? 0
    }
    
    func getAddress() -> String? {
        guard self.profile.value?.ownerProfile?.flats?.count ?? 0 > 0  else { return LocalizationKeys.noCurrentHomeSelected.rawValue.localizeString() }
        let type = self.profile.value?.ownerProfile?.flats?[0].properties?.buildingType?.capitalized
    
        let buildingNo = self.profile.value?.ownerProfile?.flats?[0].properties?.buildingNo
        let flatNo = self.profile.value?.ownerProfile?.flats?[0].flatNo
        let district = self.profile.value?.ownerProfile?.flats?[0].properties?.district
        let city = self.profile.value?.ownerProfile?.flats?[0].properties?.city

        return "\(type ?? "" ) \(buildingNo ?? "#"), \( "Flat \(flatNo ?? "")" ), \(district ?? "#"), \(city ?? "#")"
    }
}
