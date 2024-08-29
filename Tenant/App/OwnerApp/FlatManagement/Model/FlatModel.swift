//
//  FlatModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/29/24.
//

import Foundation
//
//struct FlatModel: Codable {
//    let flats: Flats?
//}
//
//// MARK: - Flats
//struct Flats: Codable {
//    let count: Int?
//    let rows: [FlatRow]?
//}
//
//// MARK: - Row
//struct FlatRow: Codable {
//    let id, propertyID: Int?
//    let tenantID: Int?
//    let flatNo: String?
//    let isDeleted: Int?
//    let type, timestamp: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case propertyID = "property_id"
//        case tenantID = "tenant_id"
//        case flatNo = "flat_no"
//        case isDeleted, type, timestamp
//    }
//}


struct FlatModel: Codable {
    let flats: Flats?
}

// MARK: - Flats
struct Flats: Codable {
    let count: Int?
    let rows: [FlatRow]?
}

// MARK: - Row
struct FlatRow: Codable {
    let id, propertyID: Int?
    let tenantID: Int?
    let flatNo: String?
    let isDeleted: Int?
    let type, timestamp: String?
    let ownersTenants: OwnersTenants?

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
struct OwnersTenants: Codable {
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
