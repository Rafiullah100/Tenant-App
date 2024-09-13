//
//  AssignViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/23/24.
//

import Foundation


class AssignViewModel {
    var errorMessage: Observable<String> = Observable("")
    var assign: Observable<AssignModel> = Observable(nil)
    var workers: Observable<CompanyWorkerModel> = Observable(nil)
    var branches: Observable<CompanyProfileModel> = Observable(nil)
    var skill: Observable<SkillModel> = Observable(nil)
    var timeSlots: Observable<TimeslotsModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func isFormValid(assign: AssignInputModel) -> ValidationResponse {
        if assign.complaintID == 0 || assign.workerID == 0 || assign.branchID == 0 || assign.skillID == 0 || assign.date.isEmpty || assign.time.isEmpty{
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else{
            guard let time12 = assign.time.components(separatedBy: " ").first else {
                return ValidationResponse(isValid: false, message: "Error")}
            let time24 = Helper.shared.convertTo24HourFormat(time12: time12)
            parameters = ["branch_id": assign.branchID, "skill_id": assign.skillID, "worker_id": assign.workerID, "complaint_id": assign.complaintID, "schedule_date": assign.date + " " + (time24 ?? "")]
            print(parameters ?? [:])
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func assignToWorker(){
        _ = URLSession.shared.request(route: .assign, method: .post, parameters: parameters, model: AssignModel.self) { result in
            switch result {
            case .success(let assign):
                self.assign.value = assign
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
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
    
    func getTimeSlots(){
        _ = URLSession.shared.request(route: .timeSlots, method: .post, parameters: [:], model: TimeslotsModel.self) { result in
            switch result {
            case .success(let slot):
                self.timeSlots.value = slot
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getWorkerCount() -> Int{
        return self.workers.value?.workers?.rows?.count ?? 0
    }
    
    func getWorkerName(at index: Int) -> String?{
        return self.workers.value?.workers?.rows?[index].name ?? ""
    }
    
    func getWorkerID(at index: Int) -> Int?{
        return self.workers.value?.workers?.rows?[index].id ?? 0
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
    
    func getSkill(at index: Int) -> SkillRow? {
        return self.skill.value?.skills?.rows?[index]
    }
    
    func getTimeSlotCount() -> Int {
        return self.timeSlots.value?.timeslots?.rows?.count ?? 0
    }
    
    func getTimeSlot(at index: Int) -> String {
        let timeFrom = self.timeSlots.value?.timeslots?.rows?[index].timeFrom ?? ""
        let timeTo = self.timeSlots.value?.timeslots?.rows?[index].timeTo ?? ""
        return  "\(timeFrom) to \(timeTo)"
    }
}
