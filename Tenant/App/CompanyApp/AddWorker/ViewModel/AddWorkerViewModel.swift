//
//  AddWorkerViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/21/24.
//

import Foundation

class AddWorkerViewModel{
    var errorMessage: Observable<String> = Observable("")
    var addWorker: Observable<AddWorkerModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func isFormValid(worker: AddWorkerInputModel) -> ValidationResponse {
        if worker.name.isEmpty || worker.contact.isEmpty || worker.branchID == 0 || worker.skillID == 0{
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else{
            parameters = ["branch_id": worker.branchID, "contact": worker.contact, "name": worker.name, "skill_ids": worker.skillID]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func loginUser(){
        _ = URLSession.shared.request(route: .addWorker, method: .post, parameters: parameters, model: AddWorkerModel.self) { result in
            switch result {
            case .success(let addWorker):
                self.addWorker.value = addWorker
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
