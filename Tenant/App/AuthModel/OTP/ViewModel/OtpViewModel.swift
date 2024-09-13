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
    var loginOtp: Observable<LoginOTPModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func verifyUSer(otp: String, type: String, contact: String){
        _ = URLSession.shared.request(route: .otp, method: .post, parameters: ["otp": otp, "type": type, "contact": contact], model: OtpModel.self) { result in
            switch result {
            case .success(let otp):
                print(otp)
                self.otp.value = otp
                guard let user = otp.user else { return }
                self.saveUserData(user: user)
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    //company, owner, tenant and worker has its own model
    func saveUserData(user: OtpUser) {
        UserDefaults.standard.name = user.name
        UserDefaults.standard.mobile = user.contact
        UserDefaults.standard.userID = user.id
        UserDefaults.standard.userType = user.type
        UserDefaults.standard.token = user.token
        UserDefaults.standard.isLogin = true
        UserDefaults.standard.uuid = user.uuid
        UserDefaults.standard.propertyIDIfTenant = user.propertyIDIfTenant
        UserDefaults.standard.flatIDIfTenant = user.flatIdIfTenant
        UserDefaults.standard.profileImage = user.profileImage
    }
    
    func loginUSer(otp: String, type: String, contact: String){
        _ = URLSession.shared.request(route: .verifyLogin, method: .post, parameters: ["otp": otp, "type": type, "contact": contact], model: LoginOTPModel.self) { result in
            switch result {
            case .success(let otp):
                print(otp)
                self.loginOtp.value = otp
                guard let user = otp.user else { return }
                self.saveUserLogin(user: user)
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    //company, owner, tenant and worker has its own model
    func saveUserLogin(user: LoginOtpUser) {
        UserDefaults.standard.name = user.name
        UserDefaults.standard.mobile = user.contact
        UserDefaults.standard.userID = user.id
        UserDefaults.standard.userType = user.type
        UserDefaults.standard.token = user.token
        UserDefaults.standard.isLogin = true
        UserDefaults.standard.propertyIDIfTenant = user.propertyIDIfTenant
        UserDefaults.standard.flatIDIfTenant = user.flatIdIfTenant
        UserDefaults.standard.profileImage = user.profileImage
    }
}
