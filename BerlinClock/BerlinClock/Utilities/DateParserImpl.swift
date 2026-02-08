//
//  DateParserImpl.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 08/02/2026
//
import Foundation

struct DateParserImpl: DateParser {
    func parseSeconds(from time: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ss"
        let secondsString = dateFormatter.string(from: time)
        return Int(secondsString)!
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
