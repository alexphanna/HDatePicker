//
//  HDatePicker.swift
//  RU Eating
//
//  Created by alex on 11/2/24.
//

import Foundation
import SwiftUI

public struct HDatePicker: View {
    @State var sunday: Date
    @State var selectedWeek: Int
    @Binding var selectedDay: Date
    private var calendar = Calendar.current
    
    public init(selectedDay: Binding<Date>) {
        sunday = calendar.date(bySetting: .weekday, value: 1, of: .now)!
        selectedWeek = -1
        _selectedDay = selectedDay
    }
    
    public var body: some View {
        VStack {
            HStack {
                Spacer()
                ForEach(["S", "M", "T", "W", "T", "F", "S"], id: \.self) { weekday in
                    Text(weekday)
                        .frame(maxWidth: .infinity)
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(weekday == "S" ? .gray : Color(UIColor.label))
                    Spacer()
                }
            }
            TabView(selection: $selectedWeek) {
                ForEach((-7...7), id: \.self) { i in
                    WeekView(sunday: Calendar.current.date(byAdding: .day, value: 7 * i, to: sunday)!, selectedDay: $selectedDay)
                        .tag(i)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 40)
        }
        .frame(height: 80)
    }
}
