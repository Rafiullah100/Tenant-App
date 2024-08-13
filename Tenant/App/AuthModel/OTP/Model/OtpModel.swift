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
    let token: String?

    enum CodingKeys: String, CodingKey {
        case id, uuid, name, contact, verified, type
        case propertyIDIfTenant = "propertyId_if_tenant"
        case token
    }
}
