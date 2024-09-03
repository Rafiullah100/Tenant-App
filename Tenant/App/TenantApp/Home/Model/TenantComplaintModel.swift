//
//  TenantComplaintModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/12/24.
//

import Foundation

struct TenantComplaintModel: Codable {
    let complaintsRecent, complaintsHistory: TenantComplaints?

    enum CodingKeys: String, CodingKey {
        case complaintsRecent = "complaints_recent"
        case complaintsHistory = "complaints_history"
    }
}

// MARK: - Complaints
struct TenantComplaints: Codable {
    let count: Int?
    let rows: [TenantComplaintsRow]?
}

// MARK: - Row
struct TenantComplaintsRow: Codable {
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
    }
}


struct TenantResidenceModel: Codable {
    let flat: TenantResidenceFlat?
}

// MARK: - Flat
struct TenantResidenceFlat: Codable {
    let id, propertyID, tenantID: Int?
    let flatNo: String?
    let isDeleted: Int?
    let type, timestamp: String?
    let properties: TenantResidenceProperties?

    enum CodingKeys: String, CodingKey {
        case id
        case propertyID = "property_id"
        case tenantID = "tenant_id"
        case flatNo = "flat_no"
        case isDeleted, type, timestamp, properties
    }
}

// MARK: - Properties
struct TenantResidenceProperties: Codable {
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
