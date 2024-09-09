//
//  URLSession+Extension.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/20/22.
//

import Foundation
import UIKit
//import SVProgressHUD
//import SpinKit
extension URLSession{
    func request<T: Codable>(route: Route, method: Method, showLoader: Bool? = true, parameters: [String: Any]? = nil, model: T.Type, completion: @escaping (Result<T, AppError>) -> Void) -> URLSessionDataTask? {
        var task: URLSessionDataTask?
//        if !Reachability.isConnectedToNetwork() {
//            completion(.failure(.noInternet))
//        }
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return task
        }
        let startTime = Date()
        task = dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error{
                    print(error)
                    DispatchQueue.main.async {
                        completion(.failure(.serverError))
                    }
                }
                else{
                    DispatchQueue.main.async {
                        completion(.failure(AppError.serverError))
                    }
                }
                return
            }
            
            print("Raw response data:", String(data: data, encoding: .utf8) ?? "N/A") // Log the raw response data

            do {
                let result = try JSONDecoder().decode(model, from: data)
                print(result)
                let endTime = Date()
                let elapsedTime = endTime.timeIntervalSince(startTime)
                print("API call took \(elapsedTime) seconds")
                
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    completion(.failure(AppError.errorDecoding))
                }
            }
        }
        task?.resume()
        return task
    }
    
    func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {

        var urlString: String!
        switch route {
            case .getAddress(let code):
                // Build the URL for the .getAddress case
            urlString = "https://geocode.search.hereapi.com/v1/geocode?"
            default:
                // Build the URL for other cases
                urlString = Route.baseUrl + route.description
            }
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(UserDefaults.standard.token ?? "", forHTTPHeaderField: "x-access-token")
        urlRequest.addValue(UserDefaults.standard.languageCode ?? "", forHTTPHeaderField: "lang-code")
        urlRequest.httpMethod = method.rawValue
//        print(urlRequest.headers)
        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}
