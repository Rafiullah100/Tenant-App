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
    let title: String?

    let buildingNo, buildingType, locationCode, city: String?
    let district: String?
    let userID, isDeleted, status: Int?
    let timestamp: String?
    let company: PropertyCompany?
    let flats: [AllPropertyFlat]?
    let propertyImages: [PropertyImages]?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case companyID = "company_id"
        case title
        case buildingNo = "building_no"
        case buildingType = "building_type"
        case locationCode = "location_code"
        case city, district
        case userID = "user_id"
        case isDeleted, status, timestamp, company, flats
        case propertyImages = "property_images"
    }
}

// MARK: - Company
struct PropertyCompany: Codable {
    let name: String?
}

// MARK: - Flat
struct AllPropertyFlat: Codable {
    let id, propertyID: Int?
    let tenantID: Int?
    let flatNo: String?
    let isDeleted: Int?
    let type, timestamp: String?
    let ownersTenants: AllPropertyOwnersTenants?

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
struct AllPropertyOwnersTenants: Codable {
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

struct PropertyImages: Codable {
    let id, propertyID: Int?
    let title, link, timestamp: String?

    enum CodingKeys: String, CodingKey {
        case id
        case propertyID = "property_id"
        case title, link, timestamp
    }
}
