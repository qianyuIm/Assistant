//
//  CodableColor.swift
//  Assistant
//
//  Created by cyd on 2021/11/19.
//  Codable Color 属性包装器

import UIKit

@propertyWrapper
struct CodableFont {
    var wrappedValue: UIFont
}

extension CodableFont: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let data = try container.decode(Data.self)
        guard let font = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIFont.self, from: data) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid font"
            )
        }
        wrappedValue = font
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let data = try NSKeyedArchiver.archivedData(withRootObject: wrappedValue, requiringSecureCoding: true)
        try container.encode(data)
    }
}
