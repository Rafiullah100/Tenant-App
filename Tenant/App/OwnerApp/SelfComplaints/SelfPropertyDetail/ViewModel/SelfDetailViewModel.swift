//
//  SelfDetailViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/30/24.
//

import Foundation

class SelfDetailViewModel {
    var errorMessage: Observable<String> = Observable("")
    var flatList: Observable<FlatModel> = Observable(nil)
    var selectHome: Observable<AssignTenantToFlatModel> = Observable(nil)

    func getList(propertyID: Int){
        _ = URLSession.shared.request(route: .getUnassignedFlats, method: .post, parameters: ["property_id": propertyID], model: FlatModel.self) { result in
            switch result {
            case .success(let list):
                self.flatList.value = list
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getCount() -> Int {
        self.flatList.value?.flats?.rows?.count ?? 0
    }
    
    func getName(at index: Int) -> String {
        let flatNo = self.flatList.value?.flats?.rows?[index].flatNo?.uppercased() ?? ""
        return "FLAT \(flatNo)"
    }
    
    func getFlatID(at index: Int) -> Int {
        let flatId = self.flatList.value?.flats?.rows?[index].id ?? 0
        return flatId
    }
    
    func isAssignedToTenant(at index: Int ) -> Bool {
        let tenantID = self.flatList.value?.flats?.rows?[index].tenantID ?? 0
        return tenantID == 0 ? false : true
    }
    
    func getFlat(at index: Int) -> FlatRow? {
        guard let flat = self.flatList.value?.flats?.rows?[index] else { return nil }
        return flat
    }
    
    func getOwnerID(at index: Int) -> Int {
        self.flatList.value?.flats?.rows?[index].ownersTenants?.id ?? 0
    }
    
    func getAssignedCompanyID(at index: Int) -> Int {
//        self.flatList.value?.flats?.rows?[index].ownersTenants?.companyId ?? 0
        return 0
    }
    
//    func getCompanyID(at index: Int) -> Int {
//        return self.companiesList.value?.companies?.rows?[index].id ?? 0
//    }
    
    func selectAsYourHome(flatID: Int, tenantID: Int){
        print(flatID, tenantID)
        _ = URLSession.shared.request(route: .assignTenantToFlat, method: .post, parameters: ["flat_id": flatID, "tenant_id": tenantID], model: AssignTenantToFlatModel.self) { result in
            switch result {
            case .success(let select):
                self.selectHome.value = select
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func isSelectedHome(at index: Int) -> String {
        let tenantID =  self.flatList.value?.flats?.rows?[index].tenantID
        
        return tenantID == UserDefaults.standard.userID ? "Your Home" : "Select as your Home"
    }
}
  
