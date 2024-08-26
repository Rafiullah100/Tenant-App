//
//  AddPropertyViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/26/24.
//

import Foundation


class AddPropertyViewModel {
    var errorMessage: Observable<String> = Observable("")
    var add: Observable<AddPropertyModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func isFormValid(property: AddPropertyInputModel) -> ValidationResponse {
        if property.name.isEmpty || property.buildingType.isEmpty || property.city.isEmpty || property.district.isEmpty || property.locationCode.isEmpty{
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else{
            parameters = ["building_no": property.name, "building_type": property.buildingType, "location_code": property.locationCode, "city": property.city, "district": property.district]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func addProperty(){
        _ = URLSession.shared.request(route: .addProperty, method: .post, parameters: parameters, model: AddPropertyModel.self) { result in
            switch result {
            case .success(let add):
                self.add.value = add
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
