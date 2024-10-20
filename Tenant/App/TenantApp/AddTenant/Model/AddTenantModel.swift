//
//  AddTenantModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/12/24.
//

import Foundation

struct AddTenantModel: Codable {
    let success: Bool?
    let message: String?
}



struct SkillModel: Codable {
    var skills: Skills?
}

// MARK: - Skills
struct Skills: Codable {
    let count: Int?
    var rows: [SkillRow]?
}

// MARK: - Row
struct SkillRow: Codable {
    let id: Int?
    let title: String?
    let userID: Int?
    let timestamp: String?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case userID = "user_id"
        case timestamp
        case imageUrl = "image_url"
    }
}
