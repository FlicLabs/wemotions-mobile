//
//  VibleWidgets.swift
//  VibleWidgets
//
//  Created by Michael Dadzie on 9/18/23.
//

import WidgetKit
import SwiftUI
import Intents
import URLImage
import Foundation

enum Constants {
    static let imageUrl = "https://socialverse-cdn-assets.s3.amazonaws.com/images/IMG_2545.JPG"
}

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> PostEntry {
        PostEntry(date: Date(), title: "The best vibes!", description: "The best vibes!", image: Constants.imageUrl)
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (PostEntry) -> ()) {
        let entry: PostEntry
        
        if context.isPreview {
            entry = placeholder(in: context)
        } else {
            // Get the data from UserDefaults to display
            let userDefaults = UserDefaults(suiteName: "group.vible")
            let title = userDefaults?.string(forKey: "title") ?? "The best vibes!"
            let description = userDefaults?.string(forKey: "description") ?? "The best vibes!"
            let image = userDefaults?.string(forKey: "image") ?? Constants.imageUrl
            entry = PostEntry(date: Date(), title: title, description: description, image: image)
        }
        
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(for: configuration, in: context) { (entry) in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}

struct PostEntry: TimelineEntry {
    let date: Date
    let title: String
    let description: String
    let image: String?
}

struct VibleWidgetsEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            if let imageURL = entry.image {
                NetworkImageView(url: URL(string: imageURL)!)
            }
            VStack(alignment: .leading) {
                Text(entry.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(4)
//                    .frame(maxHeight: .infinity, alignment: .bottom)
//                Text(entry.description)
            }
            .padding(.all, 10)
        }
    }
}

struct VibleWidgets: Widget {
    let kind: String = "VibleWidgets"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            VibleWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("Vibles")
        .description("Featured vibles to empower you to be great")
        .supportedFamilies([.systemSmall])
    }
}

struct VibleWidgets_Previews: PreviewProvider {
    static var previews: some View {
        VibleWidgetsEntryView(entry: PostEntry(date: Date(), title: "Preview Title", description: "Preview Description", image: Constants.imageUrl))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

struct PlaceHolderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(.gray)
            .frame(width: 100, height: 100)
    }
}


struct NetworkImageView: View {
    let url: URL
    
    var body: some View {
        if let data = try? Data(contentsOf: url), let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            Image(systemName: "v.circle")
        }
    }
}
