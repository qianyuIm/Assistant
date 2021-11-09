//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by cyd on 2021/11/5.
//

import WidgetKit
import SwiftUI
import Intents

struct LargeEntry: TimelineEntry {
    let date: Date
}

struct LargeWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> LargeEntry {
        LargeEntry(date: Date())
    }

    func getSnapshot(for configuration: LargeWidgetConfigurationIntent, in context: Context, completion: @escaping (LargeEntry) -> ()) {
        let entry = LargeEntry(date: Date())
        completion(entry)
    }

    func getTimeline(for configuration: LargeWidgetConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [LargeEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = LargeEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}


/// 展示的UI
struct LargeWidgetEntryView : View {
    var entry: LargeWidgetProvider.Entry
    var body: some View {
        Text("说带你什么")
    }
}

struct LargeWidget: Widget {
    let kind: String = "LargeWidget"
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: LargeWidgetConfigurationIntent.self, provider: LargeWidgetProvider()) { entry in
            LargeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("大号")
        .description("这是大号")
        .supportedFamilies([.systemLarge])
    }
}

//struct WidgetExtension_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetExtensionEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}

