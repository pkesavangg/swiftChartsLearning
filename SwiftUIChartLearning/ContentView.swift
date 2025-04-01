//
//  ContentView.swift
//  SwiftUIChartLearning
//
//  Created by Kesavan Panchabakesan on 29/03/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
//                RainFallGraphView()
                HealthMonitoringChart()
//                BarChartInteractiveGraph()
            }
        }
    }
}

#Preview {
    ContentView()
}
