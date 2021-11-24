//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by cyd on 2021/11/5.
//

import WidgetKit
import SwiftUI
import Intents

struct AppWidgetAttributes {
    var name: String?
}

struct SmallEntry: TimelineEntry {
    let date: Date
    let attributes: AppWidgetAttributes?
}

struct SmallWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SmallEntry {
        SmallEntry(date: Date(), attributes: nil)
    }

    func getSnapshot(for configuration: SmallWidgetIntent, in context: Context, completion: @escaping (SmallEntry) -> ()) {
        let entry = SmallEntry(date: Date(), attributes: nil)
        completion(entry)
    }

    func getTimeline(for configuration: SmallWidgetIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SmallEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SmallEntry(date: entryDate, attributes: nil)
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
        if entry.attributes == nil {
            WidgetPlaceholderView()
        } else {
            Text("说带你什么")
        }
    }
}

struct SmallWidget: Widget {
    let kind: String = WidgetSharedKind.small
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: SmallWidgetIntent.self, provider: SmallWidgetProvider()) { entry in
            SmallWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Small.Configuration.DisplayName")
        .description("Small.Configuration.Description")
        .supportedFamilies([.systemSmall])
    }
}

//struct WidgetExtension_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetExtensionEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
