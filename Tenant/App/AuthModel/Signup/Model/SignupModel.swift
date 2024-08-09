//
//  SignupModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/9/24.
//

import Foundation

struct SignupInputModel {
    let userType: String
    let email: String
    let mobile: String
    let name: String
}


struct SignupModel: Codable {
    let success: Bool?
    let user: SignupUser?
    let message: String?
}

// MARK: - User
struct SignupUser: Codable {
    let id: Int?
    let name, contact, type, otp: String?
}

struct ValidationResponse {
    let isValid: Bool
    let message: String
}
