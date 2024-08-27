//
//  OwnerComplaintModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/26/24.
//

import Foundation

struct OwnerComplaintModel: Codable {
    let complaintsRecent, complaintsOngoing, complaintsRejected, complaintsHistory: OwnerComplaints?

    enum CodingKeys: String, CodingKey {
        case complaintsRecent = "complaints_recent"
        case complaintsOngoing = "complaints_ongoing"
        case complaintsRejected = "complaints_rejected"
        case complaintsHistory = "complaints_history"
    }
}

// MARK: - Complaints
struct OwnerComplaints: Codable {
    let count: Int?
    let rows: [OwnerComplaintsRow]?
}

// MARK: - Row
struct OwnerComplaintsRow: Codable {
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
    let tenantApprovalDatetime: String?
    let workerAssignedDatetime, scheduleDate, scheduleTime: String?
    let timestamp: String?
    let propertyOwnerID: Int?
    let tenantName: String?
    let tenantContact: String?
    

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
        case propertyOwnerID = "property.owner_id"
        case tenantName = "tenant.name"
        case tenantContact = "tenant.contact"
    }
}



struct OwnerProfileModel: Codable {
    let ownerProfile: OwnerProfile?
}

// MARK: - OwnerProfile
struct OwnerProfile: Codable {
    let id: Int?
    let uuid, name: String?
    let email: String?
    let contact, locationCode, city, district: String?
    let isVerified: Int?
    let otp: String?
    let userID: Int?
    let registeredFrom: String?
    let type: String?
    let status, isDeleted: Int?
    let timestamp: String?
    let totalProperties, totalFlats, totalTenant: Int?

    enum CodingKeys: String, CodingKey {
        case id, uuid, name, email, contact
        case locationCode = "location_code"
        case city, district
        case isVerified = "is_verified"
        case otp
        case userID = "user_id"
        case registeredFrom = "registered_from"
        case type, status, isDeleted, timestamp, totalProperties, totalFlats, totalTenant
    }
}
