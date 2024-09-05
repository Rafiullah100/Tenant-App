//
//  AssignModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/23/24.
//

import Foundation


struct AssignModel: Codable {
    let success: Bool?
    let message: String?
}


struct TimeslotsModel: Codable {
    let timeslots: Timeslots?
}

// MARK: - Timeslots
struct Timeslots: Codable {
    let count: Int?
    let rows: [TimeslotsRow]?
}


struct TimeslotsRow: Codable {
    let timeFrom, timeTo: String?

    enum CodingKeys: String, CodingKey {
        case timeFrom = "time_from"
        case timeTo = "time_to"
    }
}
