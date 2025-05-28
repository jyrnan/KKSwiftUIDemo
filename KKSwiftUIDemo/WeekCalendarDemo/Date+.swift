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
    func currentWeek(of date: Date) -> [Date] {
        let calendar = Calendar.current
        guard let startOfWeek = calendar.dateInterval(of: .weekOfMonth, for: date)?.start else {
            return []
        }
        
        
        var week: [Date] = []
        for index in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                week.append(date)
            }
        }
        
        return week
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
}
