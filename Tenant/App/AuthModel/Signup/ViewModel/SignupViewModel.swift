//
//  SignupViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/9/24.
//

import Foundation

class SignupViewModel {
    var errorMessage: Observable<String> = Observable("")
    var signup: Observable<SignupModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func isFormValid(user: SignupInputModel) -> ValidationResponse {
        if user.name.isEmpty || user.email.isEmpty || user.mobile.isEmpty || user.name.isEmpty {
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else{
            parameters = ["name": user.name, "email": user.email, "contact": user.mobile, "type": user.userType]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func signupUser(){
        _ = URLSession.shared.request(route: .signup, method: .post, parameters: parameters, model: SignupModel.self) { result in
            switch result {
            case .success(let signup):
                self.signup.value = signup
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
