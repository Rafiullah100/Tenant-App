//
//  OtpModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/9/24.
//

import Foundation

struct OtpModel: Codable {
    let success: Bool?
    let user: OtpUser?
    let message: String?
}

// MARK: - User
struct OtpUser: Codable {
    let id: Int?
    let uuid, name, contact: String?
    let verified: Int?
    let type: String?
    let propertyIDIfTenant: Int?
    let flatIdIfTenant: Int?
    
    let token: String?

    enum CodingKeys: String, CodingKey {
        case id, uuid, name, contact, verified, type
        case propertyIDIfTenant = "propertyId_if_tenant"
        case flatIdIfTenant = "flatId_if_tenant"
        case token
    }
}


struct LoginOTPModel: Codable {
    let success: Bool?
    let user: LoginOtpUser?
    let message: String?
}

// MARK: - User
struct LoginOtpUser: Codable {
    let id: Int?
    let name, contact: String?
    let verified: Int?
    let type: String?
    let profileImage: String?
    let propertyIDIfTenant: Int?
    let flatIdIfTenant: Int?

    let token: String?

    enum CodingKeys: String, CodingKey {
        case id, name, contact, verified, type
        case profileImage = "profile_image"
        case propertyIDIfTenant = "propertyId_if_tenant"
        case flatIdIfTenant = "flatId_if_tenant"
        case token
    }
}
