//
//  CompanyModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/28/24.
//

import Foundation



struct AssignPropertyModel: Codable {
    let success: Bool?
    let message: String?
}



struct CompanyModel: Codable {
    let companies: Companies?
}

// MARK: - Companies
struct Companies: Codable {
    let count: Int?
    let rows: [CompaniesRow]?
}

// MARK: - Row
struct CompaniesRow: Codable {
    let id: Int?
    let name, contact: String?
    let email, logo, locationCode, district: String?
    let city: String?
    let registeredFrom: String?
    let isVerified: Int?
    let userID: Int?
    let otp: String?
    let status: Int?
    let isDeleted: Bool?
    let timestamp: String?
    let properties: [CompaniesProperty]?

    enum CodingKeys: String, CodingKey {
        case id, name, contact, email, logo
        case locationCode = "location_code"
        case district, city
        case registeredFrom = "registered_from"
        case isVerified = "is_verified"
        case userID = "user_id"
        case otp, status, isDeleted, timestamp, properties
    }
}

// MARK: - Property
struct CompaniesProperty: Codable {
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
