//
//  ContactModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/20/24.
//

import Foundation

struct ContactModel: Codable {
    let complaintContacts: [ComplaintContact]?

    enum CodingKeys: String, CodingKey {
        case complaintContacts = "complaint_contacts"
    }
}

// MARK: - ComplaintContact
struct ComplaintContact: Codable {
    let title, contact: String?
    let image: String?
}
