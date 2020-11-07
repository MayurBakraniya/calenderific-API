//
//  HolidayRequest.swift
//  api_Demo
//
//  Created by MAC on 29/10/20.
//

import Foundation

enum HoldayError:Error {
    case noDataAvailable
    case canNotProcessData
}

struct HolidayRequest {
    
    let ResourURl:URL
    let api_key = "5efaf47b25b6ea0675365a4b720369dcba4e98a6"
    
    init(countryCode:String) {
    
       
       
        
        
        let resourceString = "https://calendarific.com/api/v2/holidays?&api_key=\(api_key)&country=\(countryCode)&year=2020"
       
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
         self.ResourURl = resourceURL
    }
    
    func getholidays (completion: @escaping(Result<[HolidayDetail], HoldayError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: ResourURl) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decorder = JSONDecoder()
                let holidayResopnce = try decorder.decode(HolidayResponse.self , from: jsonData)
                let holidayDetails = holidayResopnce.response.holidays
                completion(.success(holidayDetails))
            }catch{
                completion(.failure(.canNotProcessData))
            }
            }
        dataTask.resume()
        }
    }



