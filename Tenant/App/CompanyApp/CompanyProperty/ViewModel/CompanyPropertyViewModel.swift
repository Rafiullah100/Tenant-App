//
//  CompanyPropertyViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 9/4/24.
//

import Foundation

class CompanyPropertyViewModel {
    var errorMessage: Observable<String> = Observable("")
    var propertyList: Observable<PropertyModel> = Observable(nil)
    
    func getProperties(search: String){
        _ = URLSession.shared.request(route: .getAssignedProperties, method: .post, parameters: ["company_id": UserDefaults.standard.userID ?? 0, "search": search], model: PropertyModel.self) { result in
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
}
