//
//  WorkerPropertyViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 9/24/24.
//
import Foundation
import UIKit
//98765432112

class WorkerPropertyViewModel {
    var errorMessage: Observable<String> = Observable("")
    var address: Observable<LocationCodeModel> = Observable(nil)

    var parameters: [String: Any]?
    private var property: Property?
    
    init(property: Property) {
        self.property = property
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
    
    func getCoordinates() -> (Double, Double) {
        let lat = self.address.value?.items?.first?.position?.lat ?? 0
        let lng = self.address.value?.items?.first?.position?.lng ?? 0
        return (lat, lng)
    }
    
    func getAddress() -> String {
       return "\(property?.buildingType?.capitalized ?? "") \(property?.buildingNo ?? ""), \(property?.district ?? ""), \(property?.city ?? "")"
    }
    
    func getPropertyTitle() -> String {
        return property?.title ?? ""
    }
    
    func getBuildingType() -> String {
        return property?.buildingType?.capitalized ?? ""
    }
    
    func getBuildingNumber() -> String {
        return property?.buildingNo ?? ""
    }
    
    func isPropertyBuilding() -> String {
        if property?.buildingType == "building" {
            return "Flat Number"
        }
        else {
            return  "Villa Number"
        }
    }
    
    func getPropertyImageCount() -> Int {
        return property?.propertyImages?.count ?? 0
    }
    
    func getPropertyImageUrl(at index: Int) -> String {
        guard let url = property?.propertyImages?[index].link else { return "" }
        return url
    }
    
    func getPropertyImages() -> [PropertyImage] {
        return property?.propertyImages ?? []
    }
    func getLocationCode() -> String {
        return property?.locationCode ?? ""
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
