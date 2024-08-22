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

    enum CodingKeys: String, CodingKey {
        case id
        case branchID = "branch_id"
        case name, email
        case isVerified = "is_verified"
        case contact, photo, timestamp
    }
}
