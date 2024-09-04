//
//  AddPropertyModel.swift
//  Tenant
//
//  Created by MacBook Pro on 8/26/24.
//

import Foundation

struct AddPropertyModel: Codable {
    let success: Bool?
    let message: String?
}




////////////
struct LocationCodeModel: Codable {
    let items: [LocationCodeItem]?
}

// MARK: - Item
struct LocationCodeItem: Codable {
    let title, id, resultType, houseNumberType: String?
    let address: LocationCodeAddress?
    let position: LocationCodePosition?
    let access: [LocationCodePosition]?
    let mapView: LocationCodeMapView?
    let scoring: LocationCodeScoring?
}

// MARK: - Position
struct LocationCodePosition: Codable {
    let lat, lng: Double?
}

// MARK: - Address
struct LocationCodeAddress: Codable {
    let label, countryCode, countryName, county: String?
    let city, district, street, postalCode: String?
    let houseNumber, building: String?
}

// MARK: - MapView
struct LocationCodeMapView: Codable {
    let west, south, east, north: Double?
}

// MARK: - Scoring
struct LocationCodeScoring: Codable {
    let queryScore: Int?
    let fieldScore: LocationCodeFieldScore?
}

// MARK: - FieldScore
struct LocationCodeFieldScore: Codable {
    let building: Int?
}
