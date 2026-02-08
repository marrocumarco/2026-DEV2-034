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

    func parseSeconds(from time: Date) -> Int {
        return Int(secondsFormatter.string(from: time))!
    }

    func parseMinutes(from time: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        let minutesString = dateFormatter.string(from: time)
        return Int(minutesString)!
    }

    func parseHours(from time: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let hoursString = dateFormatter.string(from: time)
        return Int(hoursString)!
    }
}
