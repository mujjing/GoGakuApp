//
//  Calendar + Extension.swift
//  GoGakuApp
//
//  Created by Jh's Macbook Pro on 2021/01/11.
//

import Foundation

extension Calendar {
    
    func shortFormat(_ date: Date) -> String {
        let date = dateComponents([.year,.month,.day, .weekday], from: date)
        guard let month = date.month, let day = date.day, let weekNumber = date.weekday, let weekDay = GOGAKUConst.goGakuWeekDay[weekNumber] else { fatalError() }
        return "今日 \(String(describing: month))/\(String(describing: day)) (\(weekDay))"
    }
}
