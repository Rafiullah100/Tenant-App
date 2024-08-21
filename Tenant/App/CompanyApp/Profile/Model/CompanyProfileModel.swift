//
//  CompanyModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/20/24.
//

import Foundation



struct CompanyProfileModel: Codable {
    let companyProfile: CompanyProfile?
}

// MARK: - CompanyProfile
struct CompanyProfile: Codable {
    let id: Int?
    let name, contact: String?
    let email: String?
    let logo, locationCode, district, city: String?
    let registeredFrom: String?
    let isVerified, userID: Int?
    let otp: String?
    let status: Int?
    let isDeleted: Bool?
    let timestamp: String?
    let branches: [CompanyBranch]?

    enum CodingKeys: String, CodingKey {
        case id, name, contact, email, logo
        case locationCode = "location_code"
        case district, city
        case registeredFrom = "registered_from"
        case isVerified = "is_verified"
        case userID = "user_id"
        case otp, status, isDeleted, timestamp, branches
    }
}

// MARK: - Branch
struct CompanyBranch: Codable {
    let id, companyID: Int?
    let name, contact, locationCode: String?
    let district, city: String?
    let timestamp: String?

    enum CodingKeys: String, CodingKey {
        case id
        case companyID = "company_id"
        case name, contact
        case locationCode = "location_code"
        case district, city, timestamp
    }
}
