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
    @State private var currentTab = 0
    @State var prevSunday: Date
    @State var nextSunday: Date
    
    public init(selectedDay: Binding<Date>) {
        sunday = calendar.date(byAdding: .day, value: 1 - calendar.component(.weekday, from: .now), to: .now)!
        selectedWeek = 0
        _selectedDay = selectedDay
        prevSunday = calendar.date(byAdding: .day, value: 1 - calendar.component(.weekday, from: .now) - 7, to: .now)!
        nextSunday = calendar.date(byAdding: .day, value: 1 - calendar.component(.weekday, from: .now) + 7, to: .now)!
    }
    
    public var body: some View {
        VStack(spacing: 0) {
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
            TabView(selection: $currentTab) {
                WeekView(sunday: $prevSunday, selectedDay: $selectedDay)
                    .tag(-1)
                WeekView(sunday: $sunday, selectedDay: $selectedDay)
                    .onDisappear() {
                        if currentTab != 0 {
                            sunday = currentTab < 0 ? prevSunday : nextSunday
                            currentTab = 0;
                            prevSunday = calendar.date(byAdding: .day, value: -7, to: sunday)!
                            nextSunday = calendar.date(byAdding: .day, value: 7, to: sunday)!
                        }
                    }
                    .tag(0)
                WeekView(sunday: $nextSunday, selectedDay: $selectedDay)
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            //.disabled(currentTab != 0)
        }
        .frame(height: 70)
    }
}
