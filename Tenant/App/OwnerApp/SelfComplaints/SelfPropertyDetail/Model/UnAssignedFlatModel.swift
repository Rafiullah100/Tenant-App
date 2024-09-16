//
//  UnAssignedFlatModel.swift
//  Tenant
//
//  Created by MacBook Pro on 9/16/24.
//

import Foundation

struct UnAssignedFlatModel: Codable {
    let flats: UnAssignedFlats?
}

// MARK: - Flats
struct UnAssignedFlats: Codable {
    let count: Int?
    let rows: [UnAssignedRow]?
}

// MARK: - Row
struct UnAssignedRow: Codable {
    let id, propertyID: Int?
    let tenantID: Int?
    let flatNo: String?
    let isDeleted: Int?
    let type, timestamp: String?
//    let ownersTenants: JSONNull?
    let properties: UnAssignedProperties?

    enum CodingKeys: String, CodingKey {
        case id
        case propertyID = "property_id"
        case tenantID = "tenant_id"
        case flatNo = "flat_no"
        case isDeleted, type, timestamp
//        case ownersTenants = "owners_tenants"
        case properties
    }
}

// MARK: - Properties
struct UnAssignedProperties: Codable {
    let id, ownerID, companyID: Int?
    let buildingNo, buildingType, locationCode, city: String?
    let district: String?
    let userID, isDeleted, status: Int?
    let timestamp: String?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case companyID = "company_id"
        case buildingNo = "building_no"
        case buildingType = "building_type"
        case locationCode = "location_code"
        case city, district
        case userID = "user_id"
        case isDeleted, status, timestamp
    }
}
