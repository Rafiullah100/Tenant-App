//
//  PropertyTenantsViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/30/24.
//

import Foundation

class PropertyTenantsViewModel {
    var errorMessage: Observable<String> = Observable("")
    var tenantList: Observable<PropertyTenantsModel> = Observable(nil)
    var delete: Observable<DeleteTenantModel> = Observable(nil)

    func getList(propertyID: Int, search: String){
        _ = URLSession.shared.request(route: .getPropertyTenants, method: .post, parameters: ["property_id": propertyID, "search": search], model: PropertyTenantsModel.self) { result in
            switch result {
            case .success(let list):
                self.tenantList.value = list
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getCount() -> Int {
        guard self.tenantList.value?.tenants?.rows?.count ?? 0 > 0 else{return 0}
        return self.tenantList.value?.tenants?.rows?[0].flats?.count ?? 0
    }
    
    func getTenant(at index: Int) -> PropertyTenantsFlat? {
        return self.tenantList.value?.tenants?.rows?[0].flats?[index]
    }
    
    func getTenantID(at index: Int) -> Int {
        let tenantID = self.tenantList.value?.tenants?.rows?[0].flats?[index].tenantID ?? 0
        return tenantID
    }
    
    func getFlatID(at index: Int) -> Int {
        let tenantID = self.tenantList.value?.tenants?.rows?[0].flats?[index].id ?? 0
        return tenantID
    }

    
//    func getCompanyID(at index: Int) -> Int {
//        return self.companiesList.value?.companies?.rows?[index].id ?? 0
//    }
    
    func deleteTenant(flatID: Int){
        _ = URLSession.shared.request(route: .deleteTenantFromFlat, method: .post, parameters: ["flat_id": flatID], model: DeleteTenantModel.self) { result in
            switch result {
            case .success(let delete):
                self.delete.value = delete
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
