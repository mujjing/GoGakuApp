//
//  URLExtension.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/20.
//

import Foundation

extension URL {
    
    func addPath(_ path: String) -> URL {
        return appendingPathComponent(path, isDirectory: false)
    }
    
    func addQueries(_ queries: [String: String?]) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: self.baseURL != nil) else {
            return self
        }
        var queryItems = components.queryItems ?? []
        queries.forEach { (name, value) in
            queryItems.append(URLQueryItem(name: name, value: value))
        }
        components.queryItems = queryItems
        return components.url ?? self
    }
    
    func queryValue(for name: String) -> String? {
        return queryItem(of: name)?.value
    }
    
    func queryItem(of name: String) -> URLQueryItem? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: self.baseURL != nil) else { return nil }
        return components.queryItems?.first { $0.name == name }
    }
}
