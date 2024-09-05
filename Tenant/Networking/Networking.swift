//
//  Networking.swift
//  News Hunt
//
//  Created by MacBook Pro on 10/3/23.
//

import Foundation

import Foundation
import UIKit
import Alamofire
import SDWebImage


class Networking {
    static let shared = Networking()
    
    func addComplaint(route: Route, imageParameter: String, images: [UIImage], parameters: [String: Any], completion: @escaping (Result<AddTenantModel, AppError>) -> Void) {
        print(parameters, images.count)
        let urlStr = Route.baseUrl + route.description
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "x-access-token": "\(UserDefaults.standard.token ?? "")"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            // Append parameters
            for (key, value) in parameters {
                if let valueData = "\(value)".data(using: .utf8) {
                    multipartFormData.append(valueData, withName: key)
                }
            }
            
            // Append each image
            for (index, image) in images.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
                    let imageName = "\(dateFormatter.string(from: Date()))_\(index).jpg"
                    multipartFormData.append(imageData, withName: imageParameter, fileName: imageName, mimeType: "image/jpg")
                }
            }
        }, to: urlStr, headers: headers)
        .response { response in
            // Print the raw data as a string for debugging
            if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw response: \(rawResponse)")
            }
            
            switch response.result {
            case .success:
                do {
                    let decodedResponse = try JSONDecoder().decode(AddTenantModel.self, from: response.data ?? Data())
                    completion(.success(decodedResponse))
                } catch let decodingError {
                    print("Decoding error: \(decodingError)")
                    completion(.failure(AppError.unknownError))
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                completion(.failure(AppError.unknownError))
            }
        }
    }
    
    func markComplete(route: Route, imageParameter: String, images: [UIImage], parameters: [String: Any], completion: @escaping (Result<ConfirmModel, AppError>) -> Void) {
        print(parameters, images.count)
        let urlStr = Route.baseUrl + route.description
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "x-access-token": "\(UserDefaults.standard.token ?? "")"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            // Append parameters
            for (key, value) in parameters {
                if let valueData = "\(value)".data(using: .utf8) {
                    multipartFormData.append(valueData, withName: key)
                }
            }
            
            // Append each image
            for (index, image) in images.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
                    let imageName = "\(dateFormatter.string(from: Date()))_\(index).jpg"
                    multipartFormData.append(imageData, withName: imageParameter, fileName: imageName, mimeType: "image/jpg")
                }
            }
        }, to: urlStr, headers: headers)
        .response { response in
            // Print the raw data as a string for debugging
            if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw response: \(rawResponse)")
            }
            
            switch response.result {
            case .success:
                do {
                    let decodedResponse = try JSONDecoder().decode(ConfirmModel.self, from: response.data ?? Data())
                    completion(.success(decodedResponse))
                } catch let decodingError {
                    print("Decoding error: \(decodingError)")
                    completion(.failure(AppError.unknownError))
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                completion(.failure(AppError.unknownError))
            }
        }
    }
    
    
    func addWorker(route: Route, imageParameter: String, images: [UIImage], parameters: [String: Any], completion: @escaping (Result<AddWorkerModel, AppError>) -> Void) {
        print(parameters, images.count)
        let urlStr = Route.baseUrl + route.description
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "x-access-token": "\(UserDefaults.standard.token ?? "")"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            // Append parameters
            for (key, value) in parameters {
                if let valueData = "\(value)".data(using: .utf8) {
                    multipartFormData.append(valueData, withName: key)
                }
            }
            
            // Append each image
            for (index, image) in images.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
                    let imageName = "\(dateFormatter.string(from: Date()))_\(index).jpg"
                    multipartFormData.append(imageData, withName: imageParameter, fileName: imageName, mimeType: "image/jpg")
                }
            }
        }, to: urlStr, headers: headers)
        .response { response in
            // Print the raw data as a string for debugging
            if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw response: \(rawResponse)")
            }
            
            switch response.result {
            case .success:
                do {
                    let decodedResponse = try JSONDecoder().decode(AddWorkerModel.self, from: response.data ?? Data())
                    completion(.success(decodedResponse))
                } catch let decodingError {
                    print("Decoding error: \(decodingError)")
                    completion(.failure(AppError.unknownError))
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                completion(.failure(AppError.unknownError))
            }
        }
    }
}

//    func addComplaint(route: Route, imageParameter: String, images: [UIImage], parameters: [String: Any], completion: @escaping (Result<AddTenantModel, AppError>) -> Void) {
//        print(parameters, images.count)
//        let urlStr = Route.baseUrl + route.description
//        let headers: HTTPHeaders = [
//            "Content-type": "multipart/form-data",
//            "x-access-token": "\(UserDefaults.standard.token ?? "")"
//        ]
//        
//        AF.upload(multipartFormData: { multipartFormData in
//            // Append parameters
//            for (key, value) in parameters {
//                if let valueData = "\(value)".data(using: .utf8) {
//                    multipartFormData.append(valueData, withName: key)
//                }
//            }
//            
//            // Append each image
//            for (index, image) in images.enumerated() {
//                if let imageData = image.jpegData(compressionQuality: 1.0) {
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
//                    let imageName = "\(dateFormatter.string(from: Date()))_\(index).jpg"
//                    multipartFormData.append(imageData, withName: imageParameter, fileName: imageName, mimeType: "image/jpg")
//                }
//            }
//        }, to: urlStr, headers: headers)
//        .response { response in
//            // Print the raw data as a string for debugging
//            if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
//                print("Raw response: \(rawResponse)")
//            }
//
//            switch response.result {
//            case .success:
//                do {
//                    let decodedResponse = try JSONDecoder().decode(AddTenantModel.self, from: response.data ?? Data())
//                    completion(.success(decodedResponse))
//                } catch let decodingError {
//                    print("Decoding error: \(decodingError)")
//                    completion(.failure(AppError.unknownError))
//                }
//            case .failure(let error):
//                print("Request failed with error: \(error)")
//                completion(.failure(AppError.unknownError))
//            }
//        }
//    }
//
//}




//class Networking{
//    static let shared = Networking()
////    
//    func addComplaint(route: Route, imageParameter: String, image: UIImage, parameters: [String: Any], completion: @escaping (Result<AddTenantModel, AppError>) -> Void) {
//        
//        let urlStr = Route.baseUrl + route.description
//        //        let urlRequest: Alamofire.URLRequestConvertible = URLRequest(url: url)
//        let imageData = image.jpegData(compressionQuality: 1.0)
//        let headers: HTTPHeaders = [
//            "Content-type": "multipart/form-data",
//            "x-access-token": "\(UserDefaults.standard.token ?? "")"
//        ]
//        print(UserDefaults.standard.token)
//        //file name
//        let date: Date = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
//        let imageName = "\(dateFormatter.string(from: date)).jpg"
////        let URL = try! URLRequest(url: url, method: .post, headers: headers)
////        SVProgressHUD.show(withStatus: "Please Wait...")
//        AF.upload(multipartFormData: { multipartFormData in
//            for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8) ?? Data(), withName: key as String)
//            }
//            multipartFormData.append(imageData ?? Data(), withName: imageParameter, fileName: imageName, mimeType: "image/jpg")
//        }, to: urlStr, headers: headers)
//        .responseDecodable(of: AddTenantModel.self) { (response) in
////            SVProgressHUD.dismiss()
//            switch response.result{
//            case .success(let success):
//                completion(.success(success))
//            case .failure(let error):
//                print(error)
//                completion(.failure(AppError.unknownError))
//            }
//        }
//    }
//    
    
//    func updateProfile(route: Route, imageParameter: String, image: UIImage, parameters: [String: Any], completion: @escaping (Result<ProfileUpdateModel, AppError>) -> Void) {
//
//        let urlStr = Route.baseUrl + route.description
//        //        let urlRequest: Alamofire.URLRequestConvertible = URLRequest(url: url)
//        let imageData = image.jpegData(compressionQuality: 1.0)
//        let headers: HTTPHeaders = [
//            "Content-type": "multipart/form-data",
//            "x-access-token": "\(UserDefaults.standard.accessToken ?? "")"
//        ]
//        //file name
//        let date: Date = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
//        let imageName = "\(dateFormatter.string(from: date)).jpg"
////        let URL = try! URLRequest(url: url, method: .post, headers: headers)
//        SVProgressHUD.show(withStatus: "Please Wait...")
//        AF.upload(multipartFormData: { multipartFormData in
//            for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8) ?? Data(), withName: key as String)
//            }
//            multipartFormData.append(imageData ?? Data(), withName: imageParameter, fileName: imageName, mimeType: "image/jpg")
//        }, to: urlStr, headers: headers)
//        .responseDecodable(of: ProfileUpdateModel.self) { (response) in
//            SVProgressHUD.dismiss()
//            switch response.result{
//            case .success(let profile):
//                completion(.success(profile))
//            case .failure(let error):
//                print(error)
//                completion(.failure(AppError.unknownError))
//            }
//        }
//    }
//}


//class ImagePrefetcher {
//    static func get(data: NewsModel)  {
//        var imagesUlr = [URL]()
//        data.data?.forEach({ data in
//            imagesUlr.append(URL(string: data.media ?? "") ?? URL(fileURLWithPath: ""))
//        })
//        SDWebImagePrefetcher.shared.prefetchURLs(imagesUlr)
//    }
//}
