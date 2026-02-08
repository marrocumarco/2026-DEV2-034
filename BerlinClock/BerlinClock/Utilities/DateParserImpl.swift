//
//  DateParserImpl.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 08/02/2026
//
import Foundation

class DateParserImpl: DateParser {

    private let calendar = Calendar.autoupdatingCurrent

    func parseSeconds(from time: Date) -> Int {
        calendar.component(.second, from: time)
    }

    func parseMinutes(from time: Date) -> Int {
        calendar.component(.minute, from: time)
    }

    func parseHours(from time: Date) -> Int {
        calendar.component(.hour, from: time)
    }
}
