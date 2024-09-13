//
//  AddPropertyViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/26/24.
//

import Foundation
import UIKit


class AddPropertyViewModel {
    var errorMessage: Observable<String> = Observable("")
    var add: Observable<AddPropertyModel> = Observable(nil)
    var address: Observable<LocationCodeModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func isFormValid(property: AddPropertyInputModel) -> ValidationResponse {
        if property.name.isEmpty || property.buildingType.isEmpty || property.locationCode.isEmpty{
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else if property.city.isEmpty || property.district.isEmpty {
            return ValidationResponse(isValid: false, message: "First confirm location then try!")
        }
        else if property.images == 0{
            return ValidationResponse(isValid: false, message: "Please add images and try again!")
        }
        else{
            parameters = ["building_no": property.name, "building_type": property.buildingType, "location_code": property.locationCode, "city": property.city, "district": property.district]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
//    func addProperty(){
//        _ = URLSession.shared.request(route: .addProperty, method: .post, parameters: parameters, model: AddPropertyModel.self) { result in
//            switch result {
//            case .success(let add):
//                self.add.value = add
//            case .failure(let error):
//                self.errorMessage.value = error.localizedDescription
//            }
//        }
//    }
    
    func addProperty(image: [UIImage])  {
        Networking.shared.addProperty(route: .addProperty, imageParameter: "images", images: image, parameters: parameters ?? [:]) { result in
            switch result {
            case .success(let add):
                self.add.value = add
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
    
    func getCoordinates() -> (Double, Double) {
        let lat = self.address.value?.items?.first?.position?.lat ?? 0
        let lng = self.address.value?.items?.first?.position?.lng ?? 0
        return (lat, lng)
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
