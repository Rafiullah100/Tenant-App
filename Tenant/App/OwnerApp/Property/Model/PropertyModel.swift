//
//  PropertyModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/26/24.
//

import Foundation

struct PropertyModel: Codable {
    let properties: Properties?
}

// MARK: - Properties
struct Properties: Codable {
    let count: Int?
    let rows: [PropertiesRow]?
}

// MARK: - Row
struct PropertiesRow: Codable {
    let id, ownerID: Int?
    let companyID: Int?
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
