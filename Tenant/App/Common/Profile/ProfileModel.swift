//
//  ProfileModel.swift
//  Tenant
//
//  Created by MacBook Pro on 9/26/24.
//

import Foundation

struct ProfileModel: Codable {
    let profile: Profile?

    enum CodingKeys: String, CodingKey {
        case profile = "Profile"
    }
}

// MARK: - Profile
struct Profile: Codable {
    let id, branchID: Int?
    let name: String?
    let email: String?
    let isVerified: Int?
    let contact, profileImage, registeredFrom: String?
    let status: Int?
    let otp: String?
    let timestamp: String?

    enum CodingKeys: String, CodingKey {
        case id
        case branchID = "branch_id"
        case name, email
        case isVerified = "is_verified"
        case contact
        case profileImage = "profile_image"
        case registeredFrom = "registered_from"
        case status, otp, timestamp
    }
}



struct UpdateProfileModel: Codable {
    let success: Bool?
    let data: ProfileDataClass?
    let message: String?
}

// MARK: - DataClass
struct ProfileDataClass: Codable {
    let name, profileImage: String?

    enum CodingKeys: String, CodingKey {
        case name
        case profileImage = "image_url"
    }
}
