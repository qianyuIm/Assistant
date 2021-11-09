//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by cyd on 2021/11/5.
//

import WidgetKit
import SwiftUI
import Intents

struct SmallEntry: TimelineEntry {
    let date: Date
}

struct SmallWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SmallEntry {
        SmallEntry(date: Date())
    }

    func getSnapshot(for configuration: SmallWidgetConfigurationIntent, in context: Context, completion: @escaping (SmallEntry) -> ()) {
        let entry = SmallEntry(date: Date())
        completion(entry)
    }

    func getTimeline(for configuration: SmallWidgetConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SmallEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SmallEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}


/// 展示的UI
struct SmallWidgetEntryView : View {
    var entry: SmallWidgetProvider.Entry
    var body: some View {
        Text("说带你什么")
    }
}

struct SmallWidget: Widget {
    let kind: String = "SmallWidget"
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SmallWidgetConfigurationIntent.self, provider: SmallWidgetProvider()) { entry in
            SmallWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("小号")
        .description("这是小号")
        .supportedFamilies([.systemSmall])
    }
}

//struct WidgetExtension_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetExtensionEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
