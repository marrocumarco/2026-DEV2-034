//
//  DateParser.swift
//  BerlinClock
//
//  Created by 2026-DEV2-034 on 08/02/2026
//

import Foundation

protocol DateParser {
    func parseSeconds(from time: Date) -> Int
    func parseMinutes(from time: Date) -> Int
    func parseHours(from time: Date) -> Int
}
