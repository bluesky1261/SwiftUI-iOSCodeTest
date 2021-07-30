//
//  Router.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/07/22.
//

import Foundation
import Alamofire

public enum Router: URLRequestConvertible {
    case get([String: String])
    case post([String: String])
    
    var baseUrl: URL {
        return URL(string: Server.SERVER_BASE_URL)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        case .post: return .post
        }
    }
    
    var path: String {
        switch self {
        case .get: return "get"
        case .post: return "post"
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        switch self {
        case let .get(parameters):
            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        case let .post(parameters):
            request = try JSONParameterEncoder().encode(parameters, into: request)
        }
        
        return request
    }
}
