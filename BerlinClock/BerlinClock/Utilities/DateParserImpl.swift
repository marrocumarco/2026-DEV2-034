//
//  DateParserImpl.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 08/02/2026
//
import Foundation

class DateParserImpl: DateParser {

    private let secondsFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "ss"
        return formatter
    }()

    private let minutesFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter
    }()

    private let hoursFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter
    }()

    func parseSeconds(from time: Date) -> Int {
        return Int(secondsFormatter.string(from: time))!
    }

    func parseMinutes(from time: Date) -> Int {
        return Int(minutesFormatter.string(from: time))!
    }

    func parseHours(from time: Date) -> Int {
        return Int(hoursFormatter.string(from: time))!
    }
}
