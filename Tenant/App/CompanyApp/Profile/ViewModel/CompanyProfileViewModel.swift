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
    var address: Observable<LocationCodeModel> = Observable(nil)

    
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
    
    func getAddress(locationCode: String){
        _ = URLSession.shared.request(route: .getAddress(locationCode), method: .get, parameters: ["q": locationCode, "apiKey": Constants.apiKey], model: LocationCodeModel.self) { result in
            switch result {
            case .success(let address):
                self.address.value = address
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getDistrict() -> String {
        return self.address.value?.items?.first?.address?.district ?? ""
    }
    
    func getCity() -> String {
        return self.address.value?.items?.first?.address?.city ?? ""
    }
    
    func getCoordinatesFromCode() -> (Double, Double) {
        let lat = self.address.value?.items?.first?.position?.lat ?? 0
        let lng = self.address.value?.items?.first?.position?.lng ?? 0
        return (lat, lng)
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
