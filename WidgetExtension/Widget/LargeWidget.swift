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
    let attributes: AppWidgetAttributes?
}

struct LargeWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> LargeEntry {
        LargeEntry(date: Date(), attributes: nil)
    }

    func getSnapshot(for configuration: LargeWidgetIntent, in context: Context, completion: @escaping (LargeEntry) -> ()) {
        let entry = LargeEntry(date: Date(), attributes: nil)
        completion(entry)
    }

    func getTimeline(for configuration: LargeWidgetIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [LargeEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = LargeEntry(date: entryDate, attributes: nil)
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
        if entry.attributes == nil {
            WidgetPlaceholderView()
        } else {
            Text("说带你什么")
        }
    }
}

struct LargeWidget: Widget {
    let kind: String = WidgetSharedKind.large
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: LargeWidgetIntent.self, provider: LargeWidgetProvider()) { entry in
            LargeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Large.Configuration.DisplayName")
        .description("Medium.Configuration.Description")
        .supportedFamilies([.systemLarge])
    }
}

//struct WidgetExtension_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetExtensionEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}

