//
//  CompanyModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/20/24.
//

import Foundation

struct CompanyComplaintsModel: Codable {
    let complaintsRecent, complaintsOngoing, complaintsHistory: CompanyComplaints?

    enum CodingKeys: String, CodingKey {
        case complaintsRecent = "complaints_recent"
        case complaintsOngoing = "complaints_ongoing"
        case complaintsHistory = "complaints_history"
    }
}

// MARK: - Complaints
struct CompanyComplaints: Codable {
    let count: Int?
    let rows: [CompanyComplaintsRow]?
}

// MARK: - Row
struct CompanyComplaintsRow: Codable {
    let id, rowPropertyID, flatID, skillID: Int?
    let workerID: Int?
    let rowTenantID: Int?
    let title, description: String?
    let ownerApproval: Int?
    let ownerApprovalDatetime: String?
    let companyApproval, taskComplete: Int?
    let taskCompleteDatetime, companyApprovalDatetime: String?
    let tenantApproval: Int?
    let tenantApprovalDatetime, workerAssignedDatetime, scheduleDate, scheduleTime: String?
    let timestamp: String?
    let propertyID, propertyCompanyID, tenantID: Int?
    let tenantUUID, tenantName, tenantEmail, tenantContact: String?
    let tenantLocationCode, tenantCity, tenantDistrict: String?
    let tenantIsVerified: Int?
    let tenantOtp, tenantUserID: Int?
    let tenantRegisteredFrom, tenantType: String?
    let tenantStatus, tenantIsDeleted: Int?
    let tenantTimestamp: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case rowPropertyID = "property_id"
        case flatID = "flat_id"
        case skillID = "skill_id"
        case workerID = "worker_id"
        case rowTenantID = "tenant_id"
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
        case propertyID = "property.id"
        case propertyCompanyID = "property.company.id"
        case tenantID = "tenant.id"
        case tenantUUID = "tenant.uuid"
        case tenantName = "tenant.name"
        case tenantEmail = "tenant.email"
        case tenantContact = "tenant.contact"
        case tenantLocationCode = "tenant.location_code"
        case tenantCity = "tenant.city"
        case tenantDistrict = "tenant.district"
        case tenantIsVerified = "tenant.is_verified"
        case tenantOtp = "tenant.otp"
        case tenantUserID = "tenant.user_id"
        case tenantRegisteredFrom = "tenant.registered_from"
        case tenantType = "tenant.type"
        case tenantStatus = "tenant.status"
        case tenantIsDeleted = "tenant.isDeleted"
        case tenantTimestamp = "tenant.timestamp"
    }
}
