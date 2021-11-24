//
//  WidgetPlaceholderView.swift
//  Assistant
//
//  Created by cyd on 2021/11/24.
//

import SwiftUI
import WidgetKit

struct WidgetPlaceholderView: View {
    var body: some View {
        ZStack {
            Color.black
            VStack {
                HStack {
                    Image("icon_placeholder")
                        .frame(width: 24, height: 24, alignment: .center)
                        .cornerRadius(5)
                    Text("Placeholder.Title")
                }
                VStack {
                    Text("Placeholder.Line1").font(.subheadline)
                    Text("Placeholder.Line2").font(.subheadline)
                    Text("Placeholder.Line2").font(.subheadline)
                }
            }
        }
    }
}
