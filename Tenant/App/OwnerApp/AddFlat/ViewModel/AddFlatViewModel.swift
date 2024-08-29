//
//  AddFlatViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/29/24.
//

import Foundation

class AddFlatViewModel {
    var errorMessage: Observable<String> = Observable("")
    var add: Observable<AddFlatModel> = Observable(nil)
    
    var parameters: [String: Any]?
    
    func isFormValid(flat: AddFlatInputModel) -> ValidationResponse {
        if flat.flatNo.isEmpty {
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else{
            parameters = ["flat_no": flat.flatNo, "property_id": flat.propertyID]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func addFlat(){
        _ = URLSession.shared.request(route: .addFlat, method: .post, parameters: parameters, model: AddFlatModel.self) { result in
            switch result {
            case .success(let add):
                self.add.value = add
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
