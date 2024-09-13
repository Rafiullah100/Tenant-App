//
//  CompanyViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/28/24.
//

import Foundation

class CompanyViewModel {
    var errorMessage: Observable<String> = Observable("")
    var companiesList: Observable<CompanyModel> = Observable(nil)
    var assign: Observable<AssignPropertyModel> = Observable(nil)
    
    func getList(propertyID: Int){
        _ = URLSession.shared.request(route: .companies, method: .post, parameters: ["property_id": propertyID], model: CompanyModel.self) { result in
            switch result {
            case .success(let list):
                self.companiesList.value = list
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getCount() -> Int {
        self.companiesList.value?.companies?.rows?.count ?? 0
    }
    
    func getName(at index: Int) -> String {
        return self.companiesList.value?.companies?.rows?[index].name?.capitalized ?? ""
    }
    
    func getIcon(at index: Int) -> String {
        return self.companiesList.value?.companies?.rows?[index].logo ?? ""
    }
    
    func getCompanyID(at index: Int) -> Int {
        return self.companiesList.value?.companies?.rows?[index].id ?? 0
    }
    
    func isAssigned(at index: Int) -> String{
        let propertiesCount = self.companiesList.value?.companies?.rows?[index].properties?.count
       return propertiesCount == 1 ? "Assigned" : " Assign"
    }
    
    func assignToProperty(companyID: Int, propertyID: Int){
        _ = URLSession.shared.request(route: .assignProperty, method: .post, parameters: ["company_id": companyID, "property_id": propertyID], model: AssignPropertyModel.self) { result in
            switch result {
            case .success(let assign):
                self.assign.value = assign
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
