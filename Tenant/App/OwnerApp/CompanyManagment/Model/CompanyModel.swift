//
//  CompanyModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/28/24.
//

import Foundation

struct CompanyModel: Codable {
    let companies: Companies?
}

// MARK: - Companies
struct Companies: Codable {
    let count: Int?
    let rows: [CompanyRow]?
}

// MARK: - Row
struct CompanyRow: Codable {
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

    enum CodingKeys: String, CodingKey {
        case id, name, contact, email, logo
        case locationCode = "location_code"
        case district, city
        case registeredFrom = "registered_from"
        case isVerified = "is_verified"
        case userID = "user_id"
        case otp, status, isDeleted, timestamp
    }
}



struct AssignPropertyModel: Codable {
    let success: Bool?
    let message: String?
}
