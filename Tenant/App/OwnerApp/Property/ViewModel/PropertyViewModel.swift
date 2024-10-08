//
//  PropertyViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/26/24.
//

import Foundation

class PropertyViewModel {
    var errorMessage: Observable<String> = Observable("")
    var propertyList: Observable<PropertyModel> = Observable(nil)
    var profile: Observable<OwnerProfileModel> = Observable(nil)

    func getProperties(search: String){
        _ = URLSession.shared.request(route: .properties, method: .post, parameters: ["owner_id": UserDefaults.standard.userID ?? 0, "search": search], model: PropertyModel.self) { result in
            switch result {
            case .success(let list):
                self.propertyList.value = list
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getPropertyID(at index: Int) -> Int {
        return self.propertyList.value?.properties?.rows?[index].id ?? 0
    }
    
    func getPropertiesCount() -> Int {
        return self.propertyList.value?.properties?.rows?.count ?? 0
    }
    
    func getProperty(at index: Int) -> PropertiesRow? {
        guard let property = self.propertyList.value?.properties?.rows?[index] else { return nil }
        return property
    }
    
    func getProfile(){
        _ = URLSession.shared.request(route: .ownerProfile, method: .post, parameters: ["id": UserDefaults.standard.userID ?? 0], model: OwnerProfileModel.self) { result in
            switch result {
            case .success(let profile):
                self.profile.value = profile
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getName() -> String {
        return profile.value?.ownerProfile?.name ?? "No Name"
    }
    
    func getPicture() -> String {
        return profile.value?.ownerProfile?.profileImage ?? ""
    }

    func getTotalProperty() -> Int {
        return profile.value?.ownerProfile?.totalProperties ?? 0
    }
    
    func getTenantCount() -> Int {
        return profile.value?.ownerProfile?.totalTenant ?? 0
    }
    
    func getFlatCount() -> Int {
        return profile.value?.ownerProfile?.totalFlats ?? 0
    }
    
    func getBuildingType(at index: Int) -> PropertyType {
        let type = self.propertyList.value?.properties?.rows?[index].buildingType
        return type == "building" ? .building : .villa
    }
}
