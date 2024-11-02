//
//  HDatePicker.swift
//  RU Eating
//
//  Created by alex on 11/2/24.
//

import Foundation
import SwiftUI

public struct HDatePicker: View {
    @State var selectedDate: Date = .now
    @State var accentColor: Color
    var calendar = Calendar.current
    
    public init(accentColor: Color) {
        self.selectedDate = .now
        self.accentColor = accentColor
        self.calendar = Calendar.current
    }
    
    public var body: some View {
        VStack(spacing: 3) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(fetchDates(), id: \.self) { date in
                        VStack {
                            Text(String(date.formatted(.dateTime.weekday()).first!))
                                .frame(maxWidth: .infinity)
                                .font(.caption2)
                                .fontWeight(.semibold)
                            Circle()
                                .frame(height: 36)
                                .foregroundStyle(calendar.isDate(selectedDate, inSameDayAs: date) ? calendar.isDateInToday(selectedDate) ? accentColor : (calendar.isDateInYesterday(date) ? Color(UIColor.secondaryLabel) : Color(UIColor.label)) : .clear)
                                .overlay {
                                    Text(date.formatted(.dateTime.day()))
                                        .frame(maxWidth: .infinity)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(calendar.isDate(selectedDate, inSameDayAs: date) ? Color(UIColor.systemBackground) : (calendar.isDateInYesterday(date) ? Color(UIColor.secondaryLabel) : Color(UIColor.label)))
                                }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 4)
                        .onTapGesture {
                            if !calendar.isDate(selectedDate, inSameDayAs: date) {
                                withAnimation {
                                    selectedDate = date
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
            Text(String(selectedDate.formatted(date: .complete, time: .omitted)))
        }
    }
    
    func fetchDates() -> [Date] {
        var dates: [Date] = [Date]()
        
        (-1...14).forEach { day in
            dates.append(Calendar.current.date(byAdding: .day, value: day, to: .now)!)
        }
        
        return dates
    }
}
