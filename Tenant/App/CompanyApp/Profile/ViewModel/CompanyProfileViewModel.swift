//
//  CompanyProfileViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/21/24.
//

import Foundation
import UIKit

class CompanyProfileViewModel {
    var errorMessage: Observable<String> = Observable("")
    var profile: Observable<CompanyProfileModel> = Observable(nil)
    var address: Observable<LocationCodeModel> = Observable(nil)
    var editProfile: Observable<CompanyEditProfileModel> = Observable(nil)

    var parameters: [String: Any]?
    func isFormValid(profile: CompanyUpdateProfileInputModel) -> ValidationResponse {
        if profile.name.isEmpty || profile.locationCode.isEmpty {
            return ValidationResponse(isValid: false, message: LocalizationKeys.pleaseFillAll.rawValue.localizeString())
        }
        else if profile.district.isEmpty || profile.city.isEmpty{
            return ValidationResponse(isValid: false, message: LocalizationKeys.firstConfirmLocationThenTry.rawValue.localizeString())
        }
        else{
            parameters = ["name": profile.name, "location_code": profile.locationCode, "district": profile.locationCode, "city": profile.city]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
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
    
    func updateProfile(image: UIImage)  {
        Networking.shared.updateCompanyProfile(route: .updateProfile, imageParameter: "logo", images: [image], parameters: parameters ?? [:]) { result in
            switch result {
            case .success(let edit):
                self.editProfile.value = edit
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
        print(self.profile.value?.companyProfile?.locationCode ?? "")
        return self.profile.value?.companyProfile?.locationCode ?? ""
    }
    
    func getBranchesList() -> [CompanyBranch] {
        return self.profile.value?.companyProfile?.branches ?? []
    }
    
    func getUpdatedName() -> String {
        return self.editProfile.value?.data?.name ?? ""
    }
    
    func getUpdatedProfileImage() -> String {
        return self.editProfile.value?.data?.logo ?? ""
    }
}
