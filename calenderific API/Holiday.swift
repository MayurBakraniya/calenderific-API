//
//  holiday.swift
//  api_Demo
//
//  Created by MAC on 29/10/20.
//

import Foundation

struct HolidayResponse:Decodable  {
//    var name:String
    var response:Holidays
}

struct Holidays:Decodable {
    var holidays:[HolidayDetail]
}

struct HolidayDetail:Decodable {
    var name:String
    var date:DateInfo
}

struct DateInfo:Decodable {
    var iso:String
}
