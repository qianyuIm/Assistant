//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by cyd on 2021/11/5.
//

import WidgetKit
import SwiftUI
import Intents

struct MediumEntry: TimelineEntry {
    let date: Date
}

struct MediumWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> MediumEntry {
        MediumEntry(date: Date())
    }

    func getSnapshot(for configuration: MediumWidgetIntent, in context: Context, completion: @escaping (MediumEntry) -> ()) {
        let entry = MediumEntry(date: Date())
        completion(entry)
    }

    func getTimeline(for configuration: MediumWidgetIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [MediumEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = MediumEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}


/// 展示的UI
struct MediumWidgetEntryView : View {
    var entry: MediumWidgetProvider.Entry
    var body: some View {
        Text("说带你什么")
    }
}

struct MediumWidget: Widget {
    let kind: String = WidgetSharedKind.medium
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: MediumWidgetIntent.self, provider: MediumWidgetProvider()) { entry in
            MediumWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("中号")
        .description("这是中号")
        .supportedFamilies([.systemMedium])
    }
}

//struct WidgetExtension_Previews: PreviewProvider {
//    static var previews: some View {
//        WidgetExtensionEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
