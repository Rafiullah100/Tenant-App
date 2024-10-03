//
//  ProfileViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 9/26/24.
//

import Foundation
import UIKit
class ProfileViewModel {
    var errorMessage: Observable<String> = Observable("")
    var profile: Observable<ProfileModel> = Observable(nil)
    var updateProfile: Observable<UpdateProfileModel> = Observable(nil)
    
    var parameters: [String: Any]?

    func getProfile(userID: Int, userType: UserType){
        print(userType)
        _ = URLSession.shared.request(route: .getProfile, method: .post, parameters: ["id": userID, "type": userType.rawValue], model: ProfileModel.self) { result in
            switch result {
            case .success(let profile):
                self.profile.value = profile
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getName() -> String {
        return self.profile.value?.profile?.name ?? ""
    }
    
    func getContact() -> String {
        return self.profile.value?.profile?.contact ?? ""
    }
    
    func getProfileImage() -> String {
        return self.profile.value?.profile?.profileImage ?? ""
    }
    
    func isFormValid(profile: UpdateProfileInputModel) -> ValidationResponse {
        if profile.name.isEmpty || profile.contact.isEmpty {
            return ValidationResponse(isValid: false, message: LocalizationKeys.pleaseFillAll.rawValue.localizeString())
        }
        else{
            parameters = ["id": profile.id, "name": profile.name,  "type": profile.type]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func updateProfile(image: UIImage)  {
        Networking.shared.updateProfile(route: .updateAllProfile, imageParameter: "image", images: [image], parameters: parameters ?? [:]) { result in
            switch result {
            case .success(let add):
                self.updateProfile.value = add
                guard let data = add.data else { return }
                self.saveUpdatedDetail(data: data)
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    private func saveUpdatedDetail(data: ProfileDataClass){
        UserDefaults.standard.name = data.name
        UserDefaults.standard.profileImage = data.profileImage
    }
}
