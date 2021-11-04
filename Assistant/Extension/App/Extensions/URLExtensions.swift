//
//  URLExtensions.swift
//  Assistant
//
//  Created by cyd on 2021/11/4.
//

import UIKit

extension URL: AppExtensionCompatible {}

extension AppExtensionWrapper where Base == URL {
    func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        var urlComponents = URLComponents(url: base, resolvingAgainstBaseURL: true)!
        var items = urlComponents.queryItems ?? []
        items += parameters.map({ URLQueryItem(name: $0, value: $1) })
        urlComponents.queryItems = items
        return urlComponents.url!
    }
}
