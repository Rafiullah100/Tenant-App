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
    var address: Observable<LocationCodeModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func isFormValid(branch: AddBranchInputModel) -> ValidationResponse {
        if branch.name.isEmpty || branch.locationCode.isEmpty || branch.mobile.isEmpty  {
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else if branch.district.isEmpty || branch.city.isEmpty{
            return ValidationResponse(isValid: false, message: "First confirm location then try!")
        }
        else{
            parameters = ["company_id": branch.companyID, "branch_name": branch.name, "contact": branch.mobile, "location_code": branch.locationCode, "district": branch.district, "city": branch.city]
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
    
    func getAddress(locationCode: String){
        _ = URLSession.shared.request(route: .getAddress(locationCode), method: .get, parameters: ["q": locationCode, "apiKey": Constants.apiKey], model: LocationCodeModel.self) { result in
            switch result {
            case .success(let address):
                self.address.value = address
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getDistrict() -> String {
        return self.address.value?.items?.first?.address?.district ?? ""
    }
    
    func getCity() -> String {
        return self.address.value?.items?.first?.address?.city ?? ""
    }
    
    func getCoordinatesFromCode() -> (Double, Double) {
        guard self.address.value?.items?.count ?? 0 > 0 else { return (0.0, 0.0) }
        let lat = self.address.value?.items?.first?.position?.lat ?? 0
        let lng = self.address.value?.items?.first?.position?.lng ?? 0
        return (lat, lng)
    }
    
}
