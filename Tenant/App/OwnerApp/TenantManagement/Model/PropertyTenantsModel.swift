//
//  PropertyTenantsModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/30/24.
//

import Foundation

struct PropertyTenantsModel: Codable {
    let tenants: PropertyTenants?
}

// MARK: - Tenants
struct PropertyTenants: Codable {
    let count: Int?
    let rows: [PropertyTenantsRow]?
}

// MARK: - Row
struct PropertyTenantsRow: Codable {
    let id, ownerID, companyID: Int?
    let buildingNo, buildingType, locationCode, city: String?
    let district: String?
    let userID, isDeleted, status: Int?
    let timestamp: String?
    let flats: [PropertyTenantsFlat]?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case companyID = "company_id"
        case buildingNo = "building_no"
        case buildingType = "building_type"
        case locationCode = "location_code"
        case city, district
        case userID = "user_id"
        case isDeleted, status, timestamp, flats
    }
}

// MARK: - Flat
struct PropertyTenantsFlat: Codable {
    let id, propertyID, tenantID: Int?
    let flatNo: String?
    let isDeleted: Int?
    let type, timestamp: String?
    let ownersTenants: PropertyOwnersTenants?

    enum CodingKeys: String, CodingKey {
        case id
        case propertyID = "property_id"
        case tenantID = "tenant_id"
        case flatNo = "flat_no"
        case isDeleted, type, timestamp
        case ownersTenants = "owners_tenants"
    }
}

// MARK: - OwnersTenants
struct PropertyOwnersTenants: Codable {
    let id: Int?
    let uuid, name, email, contact: String?
    let profileImage, locationCode, city, district: String?
    let isVerified: Int?
    let otp, userID: Int?
    let registeredFrom, type: String?
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
