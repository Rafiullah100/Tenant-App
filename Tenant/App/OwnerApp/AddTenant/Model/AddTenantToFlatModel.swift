//
//  AddTenantToFlatModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/29/24.
//

import Foundation

struct TenantModel: Codable {
    let tenants: Tenants?
}

// MARK: - Tenants
struct Tenants: Codable {
    let count: Int?
    let rows: [TenantsRow]?
}

// MARK: - Row
struct TenantsRow: Codable {
    let id: Int?
    let uuid, name: String?
    let email: String?
    let contact: String?
    let profileImage, locationCode, city, district: String?
    let isVerified: Int?
    let otp: String?
    let userID: Int?
    let registeredFrom: String?
    let type: String?
    let status, isDeleted: Int?
    let timestamp: String?

    enum CodingKeys: String, CodingKey {
        case id, uuid, name, email, contact
        case profileImage = "profile_image"
        case locationCode = "location_code"
        case city, district
        case isVerified = "is_verified"
        case otp
        case userID = "user_id"
        case registeredFrom = "registered_from"
        case type, status, isDeleted, timestamp
    }
}


struct AssignTenantToFlatModel: Codable {
    let success: Bool?
    let message: String?
}
