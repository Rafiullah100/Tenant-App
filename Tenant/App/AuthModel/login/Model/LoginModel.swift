//
//  LoginViewModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/9/24.
//

import Foundation

struct LoginModel: Codable {
    let success: Bool?
    let otp, message: String?
}

struct LoginInputModel {
    let userType: String
    let number: String
    let name: String
}


struct AddComplaintInputModel {
    let title: String
    let description: String
    let images: Int
//    let propertyId: Int
    let skill: Int
    
    let propertyIdIfTenant: Int
    let flatIdIfTenant: Int
}

struct AddWorkerInputModel {
    let name: String
    let contact: String
    let branchID: Int
    let skillIDs: String
}

struct AssignInputModel {
    let complaintID: Int
    let branchID: Int
    let skillID: Int
    let workerID: Int
    let date: String
    let time: String    
}

struct AddPropertyInputModel {
    let name: String
    let buildingType: String
    let locationCode: String
    let city: String
    let district: String

    
}


struct AddFlatInputModel {
    let flatNo: String
    let propertyID: Int
}
