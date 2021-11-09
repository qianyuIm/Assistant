//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by cyd on 2021/11/5.
//

import WidgetKit
import SwiftUI

/// 入口函数
@main
struct WidgetExtension: WidgetBundle {
    var body: some Widget {
        SmallWidget()
        MediumWidget()
        LargeWidget()
    }
}

