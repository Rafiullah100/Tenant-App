//
//  ProfileViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 9/26/24.
//

import Foundation

class ProfileViewModel {
    var errorMessage: Observable<String> = Observable("")
    var profile: Observable<ProfileModel> = Observable(nil)
    
    func getProfile(userID: Int, userType: UserType){
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
        return self.profile.value?.profile?.photo ?? ""
    }
    
}
