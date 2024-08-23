//
//  AddWorkerViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/21/24.
//

import Foundation

class AddWorkerViewModel{
    var errorMessage: Observable<String> = Observable("")
    var workerAdded: Observable<AddWorkerModel> = Observable(nil)
    var branches: Observable<CompanyProfileModel> = Observable(nil)
    var skill: Observable<SkillModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func isFormValid(worker: AddWorkerInputModel) -> ValidationResponse {
        if worker.name.isEmpty || worker.contact.isEmpty || worker.branchID == 0 || worker.skillIDs == ""{
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else{
            parameters = ["branch_id": worker.branchID, "contact": worker.contact, "name": worker.name, "skill_ids": worker.skillIDs]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func addWorker(){
        _ = URLSession.shared.request(route: .addWorker, method: .post, parameters: parameters, model: AddWorkerModel.self) { result in
            switch result {
            case .success(let addWorker):
                self.workerAdded.value = addWorker
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getBranches(){
        _ = URLSession.shared.request(route: .getCompanyProfile, method: .post, parameters: ["id": UserDefaults.standard.userID ?? 0], model: CompanyProfileModel.self) { result in
            switch result {
            case .success(let branches):
                self.branches.value = branches
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getSkillcategories(){
        _ = URLSession.shared.request(route: .skillCategories, method: .get, parameters: [:], model: SkillModel.self) { result in
            switch result {
            case .success(let list):
                self.skill.value = list
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getBranchesCount() -> Int{
        return self.branches.value?.companyProfile?.branches?.count ?? 0
    }
    
    func getBranchName(at index: Int) -> String{
        return self.branches.value?.companyProfile?.branches?[index].name ?? ""
    }
    
    func getBranchID(at index: Int) -> Int{
        return self.branches.value?.companyProfile?.branches?[index].id ?? 0
    }
    
    func getSkillCount() -> Int {
        return self.skill.value?.skills?.count ?? 0
    }
    
    func getSkillName(at index: Int) -> String {
        return self.skill.value?.skills?.rows?[index].title ?? ""
    }
    
    func getSkillID(at index: Int) -> Int {
        return self.skill.value?.skills?.rows?[index].id ?? 0
    }
}
