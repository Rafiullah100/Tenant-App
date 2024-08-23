//
//  CompanyWorkerModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/22/24.
//

import Foundation




struct CompanyWorkerModel: Codable {
    let workers: CompanyWorkers?
}

// MARK: - Workers
struct CompanyWorkers: Codable {
    let count: Int?
    let rows: [CompanyWorkerRow]?
}

// MARK: - Row
struct CompanyWorkerRow: Codable {
    let id, branchID: Int?
    let name: String?
    let email: String?
    let isVerified: Int?
    let contact: String?
    let photo: String?
    let timestamp: String?
    let workerSkills: [CompanyWorkerWorkerSkill]?
    let branch: CompanyWorkerBranch?

    enum CodingKeys: String, CodingKey {
        case id
        case branchID = "branch_id"
        case name, email
        case isVerified = "is_verified"
        case contact, photo, timestamp
        case workerSkills = "worker_skills"
        case branch
    }
}

// MARK: - Branch
struct CompanyWorkerBranch: Codable {
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

// MARK: - WorkerSkill
struct CompanyWorkerWorkerSkill: Codable {
    let id: Int?
    let skill: Skill?
}

// MARK: - Skill
struct CompanyWorkerSkill: Codable {
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
