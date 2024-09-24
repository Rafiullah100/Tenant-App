//
//  TenantComplaintDetailModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/13/24.
//

import Foundation

//
//struct TenantComplaintDetailModel: Codable {
//    let complaintDetail: TenantComplaintDetail?
//
//    enum CodingKeys: String, CodingKey {
//        case complaintDetail = "complaint_detail"
//    }
//}
//
//// MARK: - ComplaintDetail
//struct TenantComplaintDetail: Codable {
//    let id, propertyID: Int?
//    let flatID: Int?
//    let skillID: Int?
//    let workerID: Int?
//    let tenantID: Int?
//    let title, description: String?
//    let ownerApproval: Int?
//    let ownerApprovalDatetime: String?
//    let companyApproval, taskComplete: Int?
//    let taskCompleteDatetime, companyApprovalDatetime: String?
//    let tenantApproval: Int?
//    let tenantApprovalDatetime, workerAssignedDatetime, scheduleDate, scheduleTime: String?
//    let timestamp: String?
//    let complainImages: [TenantComplainImage]?
//    let completionImages: [String]?
////    let property: TenantComplainProperty?
////    let skill: TenantComplainSkill?
////    let tenant: TenantComplainTenant?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case propertyID = "property_id"
//        case flatID = "flat_id"
//        case skillID = "skill_id"
//        case workerID = "worker_id"
//        case tenantID = "tenant_id"
//        case title, description
//        case ownerApproval = "owner_approval"
//        case ownerApprovalDatetime = "owner_approval_datetime"
//        case companyApproval = "company_approval"
//        case taskComplete = "task_complete"
//        case taskCompleteDatetime = "task_complete_datetime"
//        case companyApprovalDatetime = "company_approval_datetime"
//        case tenantApproval = "tenant_approval"
//        case tenantApprovalDatetime = "tenant_approval_datetime"
//        case workerAssignedDatetime = "worker_assigned_datetime"
//        case scheduleDate = "schedule_date"
//        case scheduleTime = "schedule_time"
//        case timestamp
//        case complainImages = "complain_images"
//        case completionImages = "completion_images"
////        case property, skill, tenant
//    }
//}
//
////// MARK: - ComplainImage
//struct TenantComplainImage: Codable {
//    let id, complainID: Int?
//    let title: String?
//    let imageURL, timestamp: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case complainID = "complain_id"
//        case title
//        case imageURL = "image_url"
//        case timestamp
//    }
//}
//
//// MARK: - Property
//struct TenantComplainProperty: Codable {
//    let id, ownerID, companyID: Int?
//    let buildingNo, buildingType, locationCode, city: String?
//    let district: String?
//    let userID, isDeleted, status: Int?
//    let timestamp: String?
//    let company: Tenant?
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
//        case isDeleted, status, timestamp, company
//    }
//}
//
//// MARK: - Tenant
//struct TenantComplainSkill: Codable {
//    let id: Int?
//    let name, contact: String?
//    let email: String?
//    let logo: String?
//    let locationCode, district, city: String?
//    let registeredFrom: String?
//    let isVerified: Int?
//    let userID: Int?
//    let otp: String?
//    let status: Int?
//    let isDeleted: Int?
//    let timestamp, uuid, type: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, contact, email, logo
//        case locationCode = "location_code"
//        case district, city
//        case registeredFrom = "registered_from"
//        case isVerified = "is_verified"
//        case userID = "user_id"
//        case otp, status, isDeleted, timestamp, uuid, type
//    }
//}
//
//// MARK: - Skill
//struct Skill: Codable {
//    let id: Int?
//    let title: String?
//    let userID: JSONNull?
//    let timestamp: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, title
//        case userID = "user_id"
//        case timestamp
//    }
//}


struct TenantComplaintDetailModel: Codable {
    let complaintDetail: TenantComplaintDetail?

    enum CodingKeys: String, CodingKey {
        case complaintDetail = "complaint_detail"
    }
}

// MARK: - ComplaintDetail
struct TenantComplaintDetail: Codable {
    let id, propertyID: Int?
    let flatID: Int?
    let skillID: Int?
    let workerID: Int?
    let tenantID: Int?
    let title, description: String?
    let ownerApproval: Int?
    let ownerApprovalDatetime: String?
    let companyApproval, taskComplete: Int?
    let taskCompleteDatetime, companyApprovalDatetime: String?
    let tenantApproval: Int?
    let tenantApprovalDatetime, workerAssignedDatetime, scheduleDate, scheduleTime: String?
    let timestamp: String?
    let complainImages: [ComplainImage]?
    let completionImages: [ComplainImage]?
    let property: Property?
    let skill: Skill?
    let tenant: Tenant?
    let worker: DetailWorker?

    enum CodingKeys: String, CodingKey {
        case id
        case propertyID = "property_id"
        case flatID = "flat_id"
        case skillID = "skill_id"
        case workerID = "worker_id"
        case tenantID = "tenant_id"
        case title, description
        case ownerApproval = "owner_approval"
        case ownerApprovalDatetime = "owner_approval_datetime"
        case companyApproval = "company_approval"
        case taskComplete = "task_complete"
        case taskCompleteDatetime = "task_complete_datetime"
        case companyApprovalDatetime = "company_approval_datetime"
        case tenantApproval = "tenant_approval"
        case tenantApprovalDatetime = "tenant_approval_datetime"
        case workerAssignedDatetime = "worker_assigned_datetime"
        case scheduleDate = "schedule_date"
        case scheduleTime = "schedule_time"
        case timestamp
        case complainImages = "complain_images"
        case completionImages = "completion_images"
        case property, skill, tenant, worker
    }
}

// MARK: - ComplainImage
struct ComplainImage: Codable {
    let id, complainID: Int?
    let title: String?
    let imageURL, timestamp: String?

    enum CodingKeys: String, CodingKey {
        case id
        case complainID = "complain_id"
        case title
        case imageURL = "image_url"
        case timestamp
    }
}

// MARK: - Property
struct Property: Codable {
    let id, ownerID, companyID: Int?
    let buildingNo, buildingType, locationCode, city: String?
    let district: String?
    let userID, isDeleted, status: Int?
    let timestamp: String?
    let company: Tenant?
    let title: String?
    let propertyImages: [PropertyImage]?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case companyID = "company_id"
        case buildingNo = "building_no"
        case buildingType = "building_type"
        case locationCode = "location_code"
        case city, district
        case userID = "user_id"
        case isDeleted, status, timestamp, company, title
        case propertyImages = "property_images"
    }
}

struct PropertyImage: Codable {
    let id, propertyID: Int?
    let title, link, timestamp: String?

    enum CodingKeys: String, CodingKey {
        case id
        case propertyID = "property_id"
        case title, link, timestamp
    }
}

// MARK: - Tenant
struct Tenant: Codable {
    let id: Int?
    let name, contact: String?
    let email: String?
    let logo: String?
    let locationCode, district, city: String?
    let registeredFrom: String?
    let isVerified: Int?
    let userID: Int?
    let otp: String?
    let status: Int?
    let isDeleted: Int?
    let timestamp, uuid, type: String?

    enum CodingKeys: String, CodingKey {
        case id, name, contact, email, logo
        case locationCode = "location_code"
        case district, city
        case registeredFrom = "registered_from"
        case isVerified = "is_verified"
        case userID = "user_id"
        case otp, status, isDeleted, timestamp, uuid, type
    }
}

// MARK: - Skill
struct Skill: Codable {
    let id: Int?
    let title: String?
    let userID: Int?
    let timestamp: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case userID = "user_id"
        case timestamp
    }
}

struct DetailWorker: Codable {
    let id, branchID: Int?
    let name: String?
    let email: String?
    let isVerified: Int?
    let contact: String?
    let photo: String?

    enum CodingKeys: String, CodingKey {
        case id
        case branchID = "branch_id"
        case name, email
        case isVerified = "is_verified"
        case contact, photo
    }
}



//

struct ConfirmModel: Codable {
    let success: Bool?
    let message: String?
}
