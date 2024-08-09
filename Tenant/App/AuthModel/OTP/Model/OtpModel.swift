//
//  OtpModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/9/24.
//

import Foundation

struct OtpModel: Codable {
    let success: Bool?
    let user: OtpUser?
    let message: String?
}

// MARK: - User
struct OtpUser: Codable {
    let id: Int?
    let name, contact, type: String?
}
