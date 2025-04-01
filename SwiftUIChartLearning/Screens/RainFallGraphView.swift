//
//  RainFallDataLineChartView.swift
//  SwiftUIChartLearning
//
//  Created by Kesavan Panchabakesan on 29/03/25.
//
import SwiftUI
import Charts

struct RainFallGraphView: View {
    @StateObject var viewModel = RainFallDataGraphViewModel()
    @State var selectedCity = 0
    
    var cityData: [(String, String, Color)] = [
        ("New York", "🇨🇷", .red),
        ("Amsterdam", "🏳️‍🌈", .yellow),
        ("Ibiza", "🇮🇴", .green)
    ]
    
    
    var body: some View {
        VStack{
            
            Chart {
                ForEach(viewModel.getRainData(), id: \.id) { city in
                    ForEach(city.data) { weather in
                        LineMark(x: .value("Month", weather.month), y: .value("Rainfall", weather.value))
                        
                            .interpolationMethod(.catmullRom)
                            .lineStyle(StrokeStyle(lineWidth: 2.0))
                        
                        PointMark(x: .value("Month", weather.month),
                                  y: .value("Rainfall", weather.value))
                        
                    }
                    .foregroundStyle(by: .value("City", city.city))
                }
                
            }
            
           // .animation(.linear(duration: 0.5))
           // .animation(.linear(duration: 0.5), value: viewModel.isToggled)
           
            .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.5))
            .chartYAxis {
                AxisMarks(position: .leading) { _ in
                    AxisValueLabel()
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom) { _ in
                    AxisValueLabel()
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartForegroundStyleScale([
                cityData[0].0 : cityData[0].2,
                cityData[1].0 : cityData[1].2,
                cityData[2].0 : cityData[2].2,
            ])
           
            
            .padding(EdgeInsets(top: 30, leading: 10, bottom: 10, trailing:10))
            
            .frame(height: 400)
            HStack{
                Spacer()
                Text("Rainfall Data")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                Spacer()
            }
            
            VStack {
                Picker("What is your favorite color?", selection: $viewModel.selectedOne) {
                    Text("Data1").tag(0)
                    Text("Data2").tag(1)
                    Text("Data3").tag(2)
                }
                .pickerStyle(.segmented)
            }
            
            .padding(.leading)
            .padding(.trailing)
            Spacer()
        }
    }
}

struct LinechartTesting_Previews: PreviewProvider {
    static var previews: some View {
        RainFallGraphView()
    }
}

struct WeatherData: Identifiable {
    var id = UUID()
    var month: String
    var value: Int
}

struct GraphData: Identifiable {
    var id = UUID()
    var city : String
    var data: [WeatherData]
}

import SwiftUI
import Charts


class RainFallDataGraphViewModel: ObservableObject {
    @Published var selectedCity = 0
    @Published public var selectedOne = 2
    @Published var isToggled = false
    var cityRainData1 = [
        
        GraphData(city: "New York", data: [
            WeatherData(month: "Jan", value: 81),
            WeatherData(month: "Feb", value: 89),
            WeatherData(month: "Mar", value: 61),
            WeatherData(month: "Apr", value: 51),
            WeatherData(month: "May", value: 61),
            WeatherData(month: "Jun", value: 77),
            WeatherData(month: "Jul", value: 43),
            WeatherData(month: "Aug", value: 39),
            WeatherData(month: "Sep", value: 15),
            WeatherData(month: "Oct", value: 26),
            WeatherData(month: "Nov", value: 23),
            WeatherData(month: "Dec", value: 67),]
        ),
        
            GraphData(city: "Amsterdam", data: [
            WeatherData(month: "Jan", value: 21),
            WeatherData(month: "Feb", value: 39),
            WeatherData(month: "Mar", value: 41),
            WeatherData(month: "Apr", value: 61),
            WeatherData(month: "May", value: 11),
            WeatherData(month: "Jun", value: 87),
            WeatherData(month: "Jul", value: 43),
            WeatherData(month: "Aug", value: 69),
            WeatherData(month: "Sep", value: 45),
            WeatherData(month: "Oct", value: 86),
            WeatherData(month: "Nov", value: 143),
            WeatherData(month: "Dec", value: 87),
        ]),
        
            GraphData(city: "Ibiza", data: [
            WeatherData(month: "Jan", value: 31),
            WeatherData(month: "Feb", value: 49),
            WeatherData(month: "Mar", value: 51),
            WeatherData(month: "Apr", value: 61),
            WeatherData(month: "May", value: 71),
            WeatherData(month: "Jun", value: 67),
            WeatherData(month: "Jul", value: 43),
            WeatherData(month: "Aug", value: 39),
            WeatherData(month: "Sep", value: 25),
            WeatherData(month: "Oct", value: 96),
            WeatherData(month: "Nov", value: 43),
            WeatherData(month: "Dec", value: 27),
        ])
    ]
    
    
    var cityRainData2 = [
        
        GraphData(city: "New York", data: [
            WeatherData(month: "Jan", value: 18),
            WeatherData(month: "Feb", value: 98),
            WeatherData(month: "Mar", value: 16),
            WeatherData(month: "Apr", value: 15),
            WeatherData(month: "May", value: 16),
            WeatherData(month: "Jun", value: 77),
            WeatherData(month: "Jul", value: 34),
            WeatherData(month: "Aug", value: 93),
            WeatherData(month: "Sep", value: 51),
            WeatherData(month: "Oct", value: 62),
            WeatherData(month: "Nov", value: 32),
            WeatherData(month: "Dec", value: 22),
        ]),
        
        GraphData(city: "Amsterdam", data: [
            WeatherData(month: "Jan", value: 21),
            WeatherData(month: "Feb", value: 39),
            WeatherData(month: "Mar", value: 41),
            WeatherData(month: "Apr", value: 61),
            WeatherData(month: "May", value: 11),
            WeatherData(month: "Jun", value: 87),
            WeatherData(month: "Jul", value: 43),
            WeatherData(month: "Aug", value: 69),
            WeatherData(month: "Sep", value: 45),
            WeatherData(month: "Oct", value: 86),
            WeatherData(month: "Nov", value: 143),
            WeatherData(month: "Dec", value: 87),
        ]),
        
        GraphData (city: "Ibiza", data: [
            WeatherData(month: "Jan", value: 21),
            WeatherData(month: "Feb", value: 89),
            WeatherData(month: "Mar", value: 51),
            WeatherData(month: "Apr", value: 81),
            WeatherData(month: "May", value: 31),
            WeatherData(month: "Jun", value: 37),
            WeatherData(month: "Jul", value: 63),
            WeatherData(month: "Aug", value: 49),
            WeatherData(month: "Sep", value: 55),
            WeatherData(month: "Oct", value: 26),
            WeatherData(month: "Nov", value: 63),
            WeatherData(month: "Dec", value: 57),
        ])
    ]
    
    var cityRainData3 = [
        
        GraphData(city: "New York", data: [
            WeatherData(month: "Jan", value: 0),
            WeatherData(month: "Feb", value: 44),
            WeatherData(month: "Mar", value: 33),
            WeatherData(month: "Apr", value: 33),
            WeatherData(month: "May", value: 55),
            WeatherData(month: "Jun", value: 89),
            WeatherData(month: "Jul", value: 33),
            WeatherData(month: "Aug", value: 53),
            WeatherData(month: "Sep", value: 78),
            WeatherData(month: "Oct", value: 99),
            WeatherData(month: "Nov", value: 33),
            WeatherData(month: "Dec", value: 11),
        ]),
        
        GraphData(city: "Amsterdam", data: [
            WeatherData(month: "Jan", value: 21),
            WeatherData(month: "Feb", value: 39),
            WeatherData(month: "Mar", value: 41),
            WeatherData(month: "Apr", value: 61),
            WeatherData(month: "May", value: 11),
            WeatherData(month: "Jun", value: 87),
            WeatherData(month: "Jul", value: 43),
            WeatherData(month: "Aug", value: 69),
            WeatherData(month: "Sep", value: 45),
            WeatherData(month: "Oct", value: 86),
            WeatherData(month: "Nov", value: 143),
            WeatherData(month: "Dec", value: 87),
        ]),
        
        GraphData (city: "Ibiza", data: [
            WeatherData(month: "Jan", value: 21),
            WeatherData(month: "Feb", value: 89),
            WeatherData(month: "Mar", value: 51),
            WeatherData(month: "Apr", value: 81),
            WeatherData(month: "May", value: 31),
            WeatherData(month: "Jun", value: 37),
            WeatherData(month: "Jul", value: 63),
            WeatherData(month: "Aug", value: 49),
            WeatherData(month: "Sep", value: 55),
            WeatherData(month: "Oct", value: 26),
            WeatherData(month: "Nov", value: 63),
            WeatherData(month: "Dec", value: 250),
        ])
    ]
    
    
    
    func getRainData() -> [GraphData] {
        
        if  selectedOne == 0 {
            return cityRainData1
        }
        if  selectedOne == 1 {
            return cityRainData2
        }
        else{
            return cityRainData3
        }
       
    }
    
}
