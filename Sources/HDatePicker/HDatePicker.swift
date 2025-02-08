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
    @State private var minWeek = -8;
    @State private var maxWeek = 8;
    
    public init(selectedDay: Binding<Date>) {
        sunday = calendar.date(byAdding: .day, value: 1 - calendar.component(.weekday, from: .now), to: .now)!
        selectedWeek = 0
        _selectedDay = selectedDay
        print(sunday)
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
            TabView(selection: $selectedWeek) {
                ForEach(minWeek...maxWeek, id: \.self) { i in
                    WeekView(sunday: Calendar.current.date(byAdding: .day, value: 7 * i, to: sunday)!, selectedDay: $selectedDay)
                        .tag(i)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: selectedWeek) {
                if (selectedWeek % 4 == 0) {
                    minWeek = selectedWeek - 8;
                    maxWeek = selectedWeek + 8;
                }
            }
        }
        .frame(height: 70)
    }
}
