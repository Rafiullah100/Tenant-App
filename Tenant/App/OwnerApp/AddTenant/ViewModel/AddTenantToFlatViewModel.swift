//
//  AddTenantToFlatViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/29/24.
//

import Foundation

class AddTenantToFlatViewModel {
    var errorMessage: Observable<String> = Observable("")
    var tenantList: Observable<TenantModel> = Observable(nil)
    var assign: Observable<AssignTenantToFlatModel> = Observable(nil)
    
    func getList(search: String){
        _ = URLSession.shared.request(route: .tenantList, method: .post, parameters: ["search": search], model: TenantModel.self) { result in
            switch result {
            case .success(let list):
                self.tenantList.value = list
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getCount() -> Int {
        self.tenantList.value?.tenants?.rows?.count ?? 0
    }
    
    func getName(at index: Int) -> String {
        return self.tenantList.value?.tenants?.rows?[index].name?.capitalized ?? ""
    }
    
    func getTenantID(at index: Int) -> Int {
        return self.tenantList.value?.tenants?.rows?[index].id ?? 0
    }
    
    func assignToTenant(flatID: Int, tenantID: Int){
        _ = URLSession.shared.request(route: .assignTenantToFlat, method: .post, parameters: ["flat_id": flatID, "tenant_id": tenantID], model: AssignTenantToFlatModel.self) { result in
            switch result {
            case .success(let assign):
                self.assign.value = assign
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
