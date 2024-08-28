//
//  WorkersModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/27/24.
//

import Foundation


struct WorkersComplaintsModel: Codable {
    let complaintsRecent, complaintsHistory: WorkersComplaints?

    enum CodingKeys: String, CodingKey {
        case complaintsRecent = "complaints_recent"
        case complaintsHistory = "complaints_history"
    }
}

// MARK: - Complaints
struct WorkersComplaints: Codable {
    let count: Int?
    let rows: [WorkersRow]?
}

// MARK: - Row
struct WorkersRow: Codable {
    let id, propertyID, flatID, skillID: Int?
    let workerID, tenantID: Int?
    let title, description: String?
    let ownerApproval: Int?
    let ownerApprovalDatetime: String?
    let companyApproval, taskComplete: Int?
    let taskCompleteDatetime: String?
    let companyApprovalDatetime: String?
    let tenantApproval: Int?
    let tenantApprovalDatetime: String?
    let workerAssignedDatetime, scheduleDate, scheduleTime, timestamp: String?
    let tenant: WorkersTenant?

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
        case timestamp, tenant
    }
}

// MARK: - Tenant
struct WorkersTenant: Codable {
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
