import SwiftUI
import Charts

// Define the data source type
enum DataSource: String, CaseIterable, Identifiable {
    case ble = "BLE"
    case manual = "Manual"
    case wifi = "WiFi"
    var id: String { rawValue }
}

// Define the health data entry structure
struct HealthDataEntry: Identifiable {
    let id: UUID
    let timestamp: Date
    let systolic: Int
    let diastolic: Int
    let heartRate: Int
    let weight: Double
    let source: DataSource
}

let dummyHealthData: [HealthDataEntry] = [
    HealthDataEntry(
        id: UUID(),
        timestamp: Date().addingTimeInterval(-3600 * 24 * 6), // 6 days ago
        systolic: 140,
        diastolic: 90,
        heartRate: 85,
        weight: 72.0,
        source: .ble
    ),
    HealthDataEntry(
        id: UUID(),
        timestamp: Date().addingTimeInterval(-3600 * 24 * 5), // 5 days ago
        systolic: 115,
        diastolic: 75,
        heartRate: 65,
        weight: 69.5,
        source: .manual
    ),
    HealthDataEntry(
        id: UUID(),
        timestamp: Date().addingTimeInterval(-3600 * 24 * 4), // 4 days ago
        systolic: 130,
        diastolic: 85,
        heartRate: 80,
        weight: 71.0,
        source: .wifi
    ),
    HealthDataEntry(
        id: UUID(),
        timestamp: Date().addingTimeInterval(-3600 * 24 * 3), // 3 days ago
        systolic: 105,
        diastolic: 70,
        heartRate: 60,
        weight: 68.0,
        source: .ble
    ),
    HealthDataEntry(
        id: UUID(),
        timestamp: Date().addingTimeInterval(-3600 * 24 * 2), // 2 days ago
        systolic: 125,
        diastolic: 82,
        heartRate: 75,
        weight: 70.5,
        source: .manual
    ),
    HealthDataEntry(
        id: UUID(),
        timestamp: Date().addingTimeInterval(-3600 * 24 * 1), // 1 day ago
        systolic: 120,
        diastolic: 80,
        heartRate: 72,
        weight: 70.0,
        source: .wifi
    ),
    HealthDataEntry(
        id: UUID(),
        timestamp: Date(), // Today
        systolic: 118,
        diastolic: 78,
        heartRate: 70,
        weight: 69.5,
        source: .ble
    )
]

// Main chart view
struct HealthMonitoringChart: View {
    let healthData: [HealthDataEntry] = dummyHealthData
    
    @State private var selectedDate: Date?
    
    var selectedEntry: HealthDataEntry? {
        guard let selectedDate else { return nil }
        return healthData.first { Calendar.current.isDate($0.timestamp, inSameDayAs: selectedDate) }
    }
    
    // Date formatter for the x-axis and annotation
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text("Health Monitoring")
                .font(.title)
                .padding(.top)
            
            Chart {
                // Systolic blood pressure line
                
                if let selectedEntry {
                    RuleMark(
                        x: .value("Selected Date", selectedEntry.timestamp)
                    )
                    .foregroundStyle(.secondary.opacity(0.3))
                    .annotation(position: .top, spacing: 0, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(dateFormatter.string(from: selectedEntry.timestamp))
                                .font(.caption)
                                .fontWeight(.semibold)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 8, height: 8)
                                    Text("BP: \(selectedEntry.systolic)/\(selectedEntry.diastolic)")
                                        .font(.caption)
                                }
                                
                                HStack {
                                    Circle()
                                        .fill(Color.green)
                                        .frame(width: 8, height: 8)
                                    Text("HR: \(selectedEntry.heartRate) bpm")
                                        .font(.caption)
                                }
                                
                                HStack {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 8, height: 8)
                                    Text("Weight: \(String(format: "%.1f", selectedEntry.weight)) kg")
                                        .font(.caption)
                                }
                                
                                HStack {
                                    Image(systemName: sourceIcon(for: selectedEntry.source))
                                        .font(.system(size: 10))
                                    Text("Source: \(selectedEntry.source.rawValue)")
                                        .font(.caption)
                                }
                            }
                        }
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.purple.gradient))
                        .frame(width: 180)
                    }
                }
                                
                
                ForEach(healthData) { entry in
                    LineMark(
                        x: .value("Date", entry.timestamp),
                        y: .value("Systolic BP", entry.systolic)
                    )
                }
                .foregroundStyle(by: .value("Metric", "Systolic BP"))
                .symbol(by: .value("Metric", "Systolic BP"))
                .interpolationMethod(.cardinal)
                .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                
                // Diastolic blood pressure line
                ForEach(healthData) { entry in
                    LineMark(
                        x: .value("Date", entry.timestamp),
                        y: .value("Diastolic BP", entry.diastolic)
                    )
                }
                .foregroundStyle(by: .value("Metric", "Diastolic BP"))
                .symbol(by: .value("Metric", "Diastolic BP"))
                .interpolationMethod(.cardinal)
                .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                
                // Heart rate line
                ForEach(healthData) { entry in
                    LineMark(
                        x: .value("Date", entry.timestamp),
                        y: .value("Heart Rate", entry.heartRate)
                    )
                }
                .foregroundStyle(by: .value("Metric", "Heart Rate"))
                .symbol(by: .value("Metric", "Heart Rate"))
                .interpolationMethod(.cardinal)
                .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                
                // Weight line (on secondary axis)
                ForEach(healthData) { entry in
                    LineMark(
                        x: .value("Date", entry.timestamp),
                        y: .value("Weight", entry.weight)
                    )
                }
                .foregroundStyle(by: .value("Metric", "Weight"))
                .symbol(by: .value("Metric", "Weight"))
                .interpolationMethod(.cardinal)
                .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            }
            // Enable selection interaction
            .chartXSelection(value: $selectedDate.animation(.easeInOut))
            // Configure x-axis to show all dates
            .chartXAxis {
                AxisMarks(values: healthData.map { $0.timestamp }) { value in
                    if let date = value.as(Date.self) {
                        AxisValueLabel {
                            Text(dateFormatter.string(from: date))
                                .font(.footnote)
                        }
                        AxisTick()
                        AxisGridLine()
                    }
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { _ in
                    AxisGridLine()
                    AxisValueLabel()
                }
            }
            .chartLegend(position: .top, alignment: .leading)
            .frame(height: 400)
            .padding()
            
            // Optional data source indicator
            HStack {
                ForEach(DataSource.allCases) { source in
                    Label(source.rawValue, systemImage: sourceIcon(for: source))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .padding(.bottom)
        }
    }
    
    // Helper function to provide icons for data sources
    private func sourceIcon(for source: DataSource) -> String {
        switch source {
        case .ble:
            return "wave.3.right"
        case .manual:
            return "hand.tap"
        case .wifi:
            return "wifi"
        }
    }
}

#Preview {
    HealthMonitoringChart()
}

