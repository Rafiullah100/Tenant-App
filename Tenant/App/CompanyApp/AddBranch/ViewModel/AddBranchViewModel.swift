//
//  AddBranchViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/20/24.
//

import Foundation

class AddBranchViewModel {
    var errorMessage: Observable<String> = Observable("")
    var added: Observable<AddBranchModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func isFormValid(branch: AddBranchInputModel) -> ValidationResponse {
        if branch.name.isEmpty || branch.address.isEmpty || branch.mobile.isEmpty  {
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else{
            parameters = ["company_id": branch.companyID, "branch_name": branch.name, "contact": branch.mobile, "location_code": "12000", "district": "Mardan", "city": "Jalala"]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func addBranch(){
        _ = URLSession.shared.request(route: .addBranch, method: .post, parameters: parameters, model: AddBranchModel.self) { result in
            switch result {
            case .success(let branch):
                self.added.value = branch
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
}
