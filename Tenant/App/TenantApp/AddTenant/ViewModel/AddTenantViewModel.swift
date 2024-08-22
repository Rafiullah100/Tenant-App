//
//  AddTenantViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/12/24.
//

import Foundation
import UIKit
class AddTenantViewModel {
    var errorMessage: Observable<String> = Observable("")
    var add: Observable<AddTenantModel> = Observable(nil)
    var skill: Observable<SkillModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func isFormValid(complaint: AddComplaintInputModel) -> ValidationResponse {
        if complaint.title.isEmpty || complaint.description.isEmpty || complaint.skill.isEmpty || complaint.propertyId.isEmpty{
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else if complaint.images == 0{
            return ValidationResponse(isValid: false, message: "Please add images and try again!")
        }
        else{
            parameters = ["title": complaint.title, "description": complaint.description, "property_id": Int(complaint.propertyId) ?? 0, "skill_id": Int(complaint.skill) ?? 0]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
//    func addComplaint(){
//        _ = URLSession.shared.request(route: .addComplaint, method: .post, parameters: parameters, model: AddTenantModel.self) { result in
//            switch result {
//            case .success(let add):
//                self.add.value = add
//            case .failure(let error):
//                self.errorMessage.value = error.localizedDescription
//            }Orou
//        }
//    }
    
    func addComplaint(image: [UIImage])  {
        Networking.shared.addComplaint(route: .addComplaint, imageParameter: "images", images: image, parameters: parameters ?? [:]) { result in
            switch result {
            case .success(let add):
                self.add.value = add
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
    
    func getSkillCount() -> Int {
        return self.skill.value?.skills?.count ?? 0
    }
    
    func getSkillName(at index: Int) -> String {
        return self.skill.value?.skills?.rows?[index].title ?? ""
    }
}