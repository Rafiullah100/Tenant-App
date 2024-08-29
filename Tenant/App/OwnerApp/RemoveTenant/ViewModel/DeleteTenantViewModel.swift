//
//  DeleteTenantViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/29/24.
//

import Foundation

class DeleteTenantViewModel {
    var errorMessage: Observable<String> = Observable("")
    var delete: Observable<DeleteTenantModel> = Observable(nil)
    
    func deleteTenant(flatID: Int){
        _ = URLSession.shared.request(route: .deleteTenantFromFlat, method: .post, parameters: ["flat_id": flatID], model: DeleteTenantModel.self) { result in
            switch result {
            case .success(let list):
                self.delete.value = list
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
