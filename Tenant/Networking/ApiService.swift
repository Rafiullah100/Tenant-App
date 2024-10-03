//
//  ApiService.swift
//  Tenant
//
//  Created by MacBook Pro on 10/3/24.
//

import Foundation


final class ApiService {
    static let shared = ApiService()

    private init() {
        
    }
    
    func registerDeviceTokenForNotificaiton(){
//        print(UserDefaults.standard.deviceToken, UserDefaults.standard.userType)
        guard let token = UserDefaults.standard.deviceToken, let type = UserDefaults.standard.userType else { return }
        _ = URLSession.shared.request(route: .deviceToken, method: .post, parameters: ["device_token": token, "type": type], model: DevicetokenModel.self) { result in
            switch result {
            case .success(let token):
                print(token)
            case .failure(let error):
                print(error)
            }
        }
    }
}



//************************************************************//
//data
struct DevicetokenModel: Codable {
    let success: Bool?
    let data: DevicetokenData?
    let message: String?
}

// MARK: - DataClass
struct DevicetokenData: Codable {
    let deviceToken: String?

    enum CodingKeys: String, CodingKey {
        case deviceToken = "device_token"
    }
}
