//
//  APIManager.swift
//  LoginAuth
//
//  Created by Mayur Susare on 03/06/21.
//

import UIKit


struct APIManager {
    
    static func login(url: URL?, userID: String, password: String, completionHandler: @escaping (UserDetails?, URLResponse?, Error?) -> Void) {
        
        guard let url = url else {
            return
        }
        
        let parameters = "{\n\t\"user_id\":\"\(userID)\",\n\t\"password\" : \"\(password)\"\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.loginTask(with: request) { userDetails, response, error in
            completionHandler(userDetails, response, error)
        }
        task.resume()
    }
}

// MARK: - URLSession response handlers
extension URLSession {
    fileprivate func codableTask<T: Codable>(with request: URLRequest, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return self.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func loginTask(with request: URLRequest, completionHandler: @escaping (UserDetails?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: request, completionHandler: completionHandler)
    }
}
