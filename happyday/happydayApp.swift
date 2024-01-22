//
//  happydayApp.swift
//  happyday
//
//  Created by Midnight Maverick on 2024/1/22.
//

import SwiftUI
import SwiftData

@main
struct happydayApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            VideoSearchView()
//            LoginView()
//            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
