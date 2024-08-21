//
//  CompanyProfileViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/21/24.
//

import Foundation

class CompanyProfileViewModel {
    var errorMessage: Observable<String> = Observable("")
    var profile: Observable<CompanyProfileModel> = Observable(nil)
    
    
    func getProfile(companyID: Int){
        _ = URLSession.shared.request(route: .getCompanyProfile, method: .post, parameters: ["id": companyID], model: CompanyProfileModel.self) { result in
            switch result {
            case .success(let profile):
                self.profile.value = profile
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getName() -> String {
        return self.profile.value?.companyProfile?.name ?? ""
    }
    
    func getContact() -> String {
        return self.profile.value?.companyProfile?.contact ?? ""
    }
    
    func getProfileImage() -> String {
        return self.profile.value?.companyProfile?.logo ?? ""
    }
    
    func getLocationCode() -> String {
        return self.profile.value?.companyProfile?.locationCode ?? ""
    }
    
    func getBranchesList() -> [CompanyBranch] {
        return self.profile.value?.companyProfile?.branches ?? []
    }
}
