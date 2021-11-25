//
//  AppDisplayMode.swift
//  Assistant
//
//  Created by cyd on 2021/11/25.
//  用于 App 主题判断

import SwiftyUserDefaults

enum AppDisplayMode: String, DefaultsSerializable {
    case inferred
    case light
    case dark
}
