//
//  StringFormatDemo.swift
//  KKSwiftUIDemo
//
//  Created by jyrnan on 2025/5/7.
//

import SwiftUI

struct StringFormatDemo: View {
    var body: some View {
        VStack{
            let distance = Measurement(value: 3200, unit: UnitLength.meters)
            Text("Measurement: \(distance, format: .measurement(width: .abbreviated))")
                .environment(\.locale, .init(identifier: "en_US"))
            
            let date = Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 7, hour: 11))!
            
            Text("Date: \(date, style: .offset)")
                .monospacedDigit()
        }
    }
}

#Preview {
    StringFormatDemo()
}
