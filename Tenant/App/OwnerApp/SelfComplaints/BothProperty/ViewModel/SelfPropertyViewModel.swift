//
//  SelfComplaintsViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/30/24.
//

import Foundation

class SelfPropertyViewModel {
    var errorMessage: Observable<String> = Observable("")
    var propertyList: Observable<PropertyModel> = Observable(nil)
    var selectHome: Observable<AssignTenantToFlatModel> = Observable(nil)

    func getProperties(){
        _ = URLSession.shared.request(route: .properties, method: .post, parameters: ["owner_id": UserDefaults.standard.userID ?? 0], model: PropertyModel.self) { result in
            switch result {
            case .success(let list):
                self.propertyList.value = list
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getOwnerID(at index: Int) -> Int {
        return self.propertyList.value?.properties?.rows?[index].ownerID ?? 0
    }
    
    func getFlatID(at index: Int) -> Int {
        let flatCount =  self.propertyList.value?.properties?.rows?[index].flats?.count ?? 0
        guard flatCount > 0 else { return 0 }
        return self.propertyList.value?.properties?.rows?[index].flats?[0].id ?? 0
    }
    
    func getPropertiesCount() -> Int {
        return self.propertyList.value?.properties?.rows?.count ?? 0
    }
    
    func getProperty(at index: Int) -> PropertiesRow? {
        guard let property = self.propertyList.value?.properties?.rows?[index] else { return nil }
        return property
    }
    
    func selectAsYourHome(flatID: Int, tenantID: Int){
        _ = URLSession.shared.request(route: .assignTenantToFlat, method: .post, parameters: ["flat_id": flatID, "tenant_id": tenantID], model: AssignTenantToFlatModel.self) { result in
            switch result {
            case .success(let select):
                
                self.selectHome.value = select
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
//    func getProfile(){
//        _ = URLSession.shared.request(route: .ownerProfile, method: .post, parameters: ["id": UserDefaults.standard.userID ?? 0], model: OwnerProfileModel.self) { result in
//            switch result {
//            case .success(let profile):
//                self.profile.value = profile
//            case .failure(let error):
//                self.errorMessage.value = error.localizedDescription
//            }
//        }
//    }
//    
//    func getName() -> String {
//        return profile.value?.ownerProfile?.name ?? "No Name"
//    }
//
//    func getTotalProperty() -> Int {
//        return profile.value?.ownerProfile?.totalProperties ?? 0
//    }
//    
//    func getTenantCount() -> Int {
//        return profile.value?.ownerProfile?.totalTenant ?? 0
//    }
//    
//    func getFlatCount() -> Int {
//        return profile.value?.ownerProfile?.totalFlats ?? 0
//    }
    
//    func isVillaAssigned(at index: Int) -> Bool {
//        <#function body#>
//    }
    
    func isSelectedHome(at index: Int) -> Bool {
        print(self.propertyList.value?.properties?.rows?[index].flats?[0].id ?? 0, self.propertyList.value?.properties?.rows?[index].flats?[0].tenantID ?? 0)
        let flatCount =  self.propertyList.value?.properties?.rows?[index].flats?.count ?? 0
        guard flatCount > 0 else { return false }
        let tenantID =  self.propertyList.value?.properties?.rows?[index].flats?[0].tenantID ?? 0
        if tenantID == UserDefaults.standard.userID {
            return true
        }
        else{
            return false
        }
    }
    
    func getBuildingType(at index: Int) -> PropertyType {
        let type = self.propertyList.value?.properties?.rows?[index].buildingType
        return type == "building" ? .building : .villa
    }
}
