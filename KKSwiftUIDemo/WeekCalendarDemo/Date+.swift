//
//  Date+.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/22.
//


import Foundation

extension Date {
    static var currentWeek: [Day] {
        let calendar = Calendar.current
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) else {
            return []
        }
        
        
        var week: [Day] = []
        for index in 0..<7 {
            if let day = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                week.append(.init(date: day))
            }
        }
        
        return week
    }
    func currentWeek(of date: Date = .now) -> Week {
        let calendar = Calendar.current
        guard let startOfWeek = calendar.dateInterval(of: .weekOfMonth, for: date)?.start else {
            return .init(days: Date.currentWeek)
        }
        
        
        var weekDays: [Day] = []
        for index in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                weekDays.append(Day.init(date:date))
            }
        }
        
        return .init(days: weekDays)
    }
    
    func preWeek(of week: Week) -> Week {
        let calendar = Calendar.current
        guard let firstDay = week.days.first?.date,
              let preWeekDay = calendar.date(byAdding: .weekOfYear, value: -1, to: firstDay) else { return currentWeek()}
        return currentWeek(of: preWeekDay)
    }
    
    func nextWeek(of week: Week) -> Week {
        let calendar = Calendar.current
        guard let firstDay = week.days.first?.date,
              let nextWeekDay = calendar.date(byAdding: .weekOfYear, value: 1, to: firstDay) else { return currentWeek()}
        return currentWeek(of: nextWeekDay)
    }
    
    func currentWeeks() -> [Week] {
        let currentWeek = currentWeek()
       return [preWeek(of: currentWeek), currentWeek, nextWeek(of: currentWeek)]
    }
    
    func string(_ format:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func isSame(_ date: Date?) -> Bool {
        guard let date = date else { return false }
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: date)
    }
    
    struct Day: Identifiable {
        var id: String = UUID().uuidString
        var date: Date
    }
    
    struct Week: Identifiable {
        var id: String = UUID().uuidString
        var days: [Day]
    }

}
