//
//  LoginViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/9/24.
//

import Foundation

class LoginViewModel {
    var errorMessage: Observable<String> = Observable("")
    var login: Observable<LoginModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func isFormValid(user: LoginInputModel) -> ValidationResponse {
        let contact = user.number.replacingOccurrences(of: " ", with: "")
        if user.name.isEmpty || user.number.isEmpty || user.userType.isEmpty{
            return ValidationResponse(isValid: false, message: LocalizationKeys.pleaseFillAll.rawValue.localizeString())
        }
        else if contact.count < 10{
            return ValidationResponse(isValid: false, message: LocalizationKeys.enterCorrectNumber.rawValue.localizeString())
        }
        else{
            parameters = ["name": user.name, "contact": user.number, "type": user.userType]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func loginUser(){
        _ = URLSession.shared.request(route: .login, method: .post, parameters: parameters, model: LoginModel.self) { result in
            switch result {
            case .success(let login):
                self.login.value = login
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
//    func saveUserData(userData: SignupUserDataModel) {
//        UserDefaults.standard.name = userData.name
//        UserDefaults.standard.email = userData.email
//        UserDefaults.standard.mobile = userData.mobileNo
//        UserDefaults.standard.profileImage = userData.profileImage
//        UserDefaults.standard.uuid = userData.uuid
//        UserDefaults.standard.token = userData.token
//    }
}
