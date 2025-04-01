//
//  ContentView2.swift
//  SwiftUIChartLearning
//
//  Created by Kesavan Panchabakesan on 29/03/25.
//


import SwiftUI
import Charts


struct BarChartInteractiveGraph: View {
    @State var rawSelectedDate: Date?
    
    var selectedViewMonth: ViewMonth? {
        guard let rawSelectedDate else { return nil }
        return ViewMonth.mockData.first {
            Calendar.current.isDate(rawSelectedDate, equalTo: $0.date, toGranularity: .month)
        }
    }
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 4) {
                Text("YouTube Views")
                    .bold()
                    .padding(.top)


                Text("Total: \(ViewMonth.mockData.reduce(0, { $0 + $1.viewCount }))")
                    .fontWeight(.semibold)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 12)


                Chart {
                    
                    if let selectedViewMonth {
                        RuleMark(
                            x: .value("Selected Month", selectedViewMonth.date, unit: .month)
                        )
                        .foregroundStyle(.secondary.opacity(0.3))
                        .annotation(position: .top, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                            VStack {
                                Text(selectedViewMonth.date, format: .dateTime.month(.wide))
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                Text("\(selectedViewMonth.viewCount)")
                                    .font(.headline)
                                    .fontWeight(.bold)
                            }
                            .foregroundStyle(.white)
                            .padding(12)
                            .frame(width: 120)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.pink.gradient))
                                
                        }
                        
                    }
                    
                    ForEach(ViewMonth.mockData) { viewMonth in
                        BarMark(
                            x: .value("Month", viewMonth.date, unit: .month),
                            y: .value("Views", viewMonth.viewCount)
                        )
                        .foregroundStyle(Color.pink.gradient)
                        .opacity((rawSelectedDate == nil || viewMonth.date == selectedViewMonth?.date) ?  1.0 : 0.3)
                    }
                }
                .frame(height: 180)
                .chartXSelection(value: $rawSelectedDate.animation(.easeInOut))
                .chartXAxis {
                    AxisMarks {
                        AxisValueLabel()
                        AxisGridLine()
                    }
                }
                .chartYAxis {
                    AxisMarks {
                        AxisValueLabel()
                        AxisGridLine()
                    }
                }
                .padding(.bottom)


                Spacer()
            }
        }
        .padding(30)
    }
}


#Preview {
    BarChartInteractiveGraph()
}


struct ViewMonth: Identifiable {
    let id = UUID()
    let date: Date
    let viewCount: Int


    static let mockData: [ViewMonth] = [
        .init(date: Date.from(year: 2024, month: 1, day: 1), viewCount: 55000),
        .init(date: Date.from(year: 2024, month: 2, day: 1), viewCount: 89000),
        .init(date: Date.from(year: 2024, month: 3, day: 1), viewCount: 64000),
        .init(date: Date.from(year: 2024, month: 4, day: 1), viewCount: 79000),
        .init(date: Date.from(year: 2024, month: 5, day: 1), viewCount: 130000),
        .init(date: Date.from(year: 2024, month: 6, day: 1), viewCount: 90000),
        .init(date: Date.from(year: 2024, month: 7, day: 1), viewCount: 88000),
        .init(date: Date.from(year: 2024, month: 8, day: 1), viewCount: 64000),
        .init(date: Date.from(year: 2024, month: 9, day: 1), viewCount: 74000),
        .init(date: Date.from(year: 2024, month: 10, day: 1), viewCount: 99000),
        .init(date: Date.from(year: 2024, month: 11, day: 1), viewCount: 110000),
        .init(date: Date.from(year: 2024, month: 12, day: 1), viewCount: 94000)
    ]
}


extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}
