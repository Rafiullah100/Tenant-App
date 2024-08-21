//
//  AddBranchModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/20/24.
//

import Foundation

struct AddBranchModel: Codable {
    let success: Bool?
    let message: String?
}

struct AddBranchInputModel {
    let companyID: Int
    let name: String
    let address: String
    let mobile: String
}
