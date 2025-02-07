//
//  WeekView.swift
//  HDatePicker
//
//  Created by alex on 11/3/24.
//

import SwiftUI

public struct WeekView: View {
    @State var sunday: Date
    @Binding var selectedDay: Date
    var calendar = Calendar.current
    
    public var body: some View {
        HStack {
            Spacer()
            ForEach(getWeek(), id: \.self) { day in
                DayView(day: day, selectedDay: $selectedDay)
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        if !calendar.isDate(selectedDay, inSameDayAs: day) {
                            withAnimation {
                                selectedDay = day
                            }
                        }
                    }
                Spacer()
            }
        }
    }
    
    func getWeek() -> [Date] {
        var dates: [Date] = [Date]()
        
        for i in 0..<7 {
            dates.append(Calendar.current.date(byAdding: .day, value: i, to: sunday)!)
        }
        
        return dates
    }
    
    private struct DayView: View {
        @State var day: Date
        @Binding var selectedDay: Date
        var calendar = Calendar.current
        
        var body: some View {
            var isSelected: Bool = calendar.isDate(day, inSameDayAs: selectedDay)
            VStack {
                ZStack {
                    Circle()
                        .foregroundStyle(isSelected ? (calendar.isDateInToday(day) ? .accentColor : Color(UIColor.label)) : .clear)
                        .frame(width: 35)
                    Text(day.formatted(.dateTime.day()))
                        .frame(maxWidth: .infinity)
                        .font(.body)
                        .foregroundStyle(
                            isSelected ?
                              (calendar.isDateInToday(day) ? Color(UIColor.label) : Color(UIColor.systemBackground))
                            : (calendar.isDateInWeekend(day) ? (calendar.isDateInToday(day) ? .accentColor : .gray)
                            : (calendar.isDateInToday(day) ? .accentColor : Color(UIColor.label)))
                        )
                }
            }
        }
    }
}
