//
//  OtpViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/9/24.
//

import Foundation

class OtpViewModel {
    var errorMessage: Observable<String> = Observable("")
    var otp: Observable<OtpModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func verifyUSer(otp: String, type: String){
        _ = URLSession.shared.request(route: .otp, method: .post, parameters: ["otp": otp, "type": type], model: OtpModel.self) { result in
            switch result {
            case .success(let otp):
                self.otp.value = otp
                guard let user = otp.user else { return }
                self.saveUserData(user: user)
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func saveUserData(user: OtpUser) {
        UserDefaults.standard.name = user.name
        UserDefaults.standard.mobile = user.contact
        UserDefaults.standard.userID = user.id
        UserDefaults.standard.userType = user.type
    }
}
