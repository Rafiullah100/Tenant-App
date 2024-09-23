//
//  CompanyWorkerViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/22/24.
//

import Foundation

class CompanyWorkerViewModel{
    var errorMessage: Observable<String> = Observable("")
    var workers: Observable<CompanyWorkerModel> = Observable(nil)
    var branches: Observable<CompanyProfileModel> = Observable(nil)
    var skill: Observable<SkillModel> = Observable(nil)
    
    func getWorkers(branchID: Int? = nil, skillID: Int? = nil){
        var parameters = [String: Int]()
        if branchID == nil && skillID == nil {
            parameters = [:]
        }
        else if branchID == nil{
            parameters = ["skill_id": skillID ?? 0]
        }
        else if skillID == nil{
            parameters = ["branch_id": branchID ?? 0]
        }
        else {
            parameters = ["branch_id": branchID ?? 0, "skill_id": skillID ?? 0]
        }
        print(parameters)
        
        _ = URLSession.shared.request(route: .getWorker, method: .post, parameters: parameters, model: CompanyWorkerModel.self) { result in
            switch result {
            case .success(let workers):
                self.workers.value = workers
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
    
    func getWorkerCount() -> Int{
        return self.workers.value?.workers?.rows?.count ?? 0
    }
    
    func getWorker(at index: Int) -> CompanyWorkerRow?{
        return self.workers.value?.workers?.rows?[index]
    }
    
    func getBranchesCount() -> Int{
        return self.branches.value?.companyProfile?.branches?.count ?? 0
    }
    
    func getBranchName(at index: Int) -> String{
        guard self.branches.value?.companyProfile?.branches?.count ?? 0 > 0 else { return "" }
        return self.branches.value?.companyProfile?.branches?[index].name?.capitalized ?? ""
    }
    
    func getBranchID(at index: Int) -> Int{
        guard self.branches.value?.companyProfile?.branches?.count ?? 0 > 0 else { return 0 }
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
    
    func getSkill(at index: Int) -> SkillRow? {
        return self.skill.value?.skills?.rows?[index]
    }
}
