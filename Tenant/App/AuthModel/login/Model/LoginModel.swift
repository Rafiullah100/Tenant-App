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
    let propertyId: String
    let skill: String
    
}
