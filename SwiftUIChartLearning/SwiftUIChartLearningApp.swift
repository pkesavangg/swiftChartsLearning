//
//  SwiftUIChartLearningApp.swift
//  SwiftUIChartLearning
//
//  Created by Kesavan Panchabakesan on 29/03/25.
//

import SwiftUI

@main
struct SwiftUIChartLearningApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
