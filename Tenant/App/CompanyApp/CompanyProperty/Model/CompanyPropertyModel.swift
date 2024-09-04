////
////  CompanyPropertyModel.swift
////  Tenant
////
////  Created by MacBook Pro on 9/4/24.
////
//
//import Foundation
//
//struct CompanyAssignedPropertyModel: Codable {
//    let Companyproperties: CompanyAssignedProperties?
//}
//
//// MARK: - Properties
//struct CompanyAssignedProperties: Codable {
//    let count: Int?
//    let rows: [CompanyAssignedRow]?
//}
//
//// MARK: - Row
//struct CompanyAssignedRow: Codable {
//    let id, ownerID, companyID: Int?
//    let buildingNo, buildingType, locationCode, city: String?
//    let district: String?
//    let userID, isDeleted, status: Int?
//    let timestamp: String?
////    let company: CompanyAssignedCompany?
////    let flats: [CompanyAssignedFlat]?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case ownerID = "owner_id"
//        case companyID = "company_id"
//        case buildingNo = "building_no"
//        case buildingType = "building_type"
//        case locationCode = "location_code"
//        case city, district
//        case userID = "user_id"
//        case isDeleted, status, timestamp
////        , company, flats
//    }
//}
//
////// MARK: - Company
////struct CompanyAssignedCompany: Codable {
////    let name: String?
////}
////
////// MARK: - Flat
////struct CompanyAssignedFlat: Codable {
////    let id, propertyID: Int?
////    let tenantID: Int?
////    let flatNo: String?
////    let isDeleted: Int?
////    let type, timestamp: String?
////    let ownersTenants: CompanyAssignedOwnersTenants?
////
////    enum CodingKeys: String, CodingKey {
////        case id
////        case propertyID = "property_id"
////        case tenantID = "tenant_id"
////        case flatNo = "flat_no"
////        case isDeleted, type, timestamp
////        case ownersTenants = "owners_tenants"
////    }
////}
////
////// MARK: - OwnersTenants
////struct CompanyAssignedOwnersTenants: Codable {
////    let id: Int?
////    let uuid, name: String?
////    let email: String?
////    let contact: String?
////    let profileImage, locationCode, city, district: String?
////    let isVerified: Int?
////    let otp: Int?
////    let userID: Int?
////    let registeredFrom: String?
////    let type: String?
////    let status, isDeleted: Int?
////    let timestamp: String?
////
////    enum CodingKeys: String, CodingKey {
////        case id, uuid, name, email, contact
////        case profileImage = "profile_image"
////        case locationCode = "location_code"
////        case city, district
////        case isVerified = "is_verified"
////        case otp
////        case userID = "user_id"
////        case registeredFrom = "registered_from"
////        case type, status, isDeleted, timestamp
////    }
////}
