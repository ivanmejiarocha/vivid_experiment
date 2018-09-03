//
//  VividSeatsService.swift
//  VividApp
//
//  Created by Ivan Mejia on 9/3/18.
//  Copyright © 2018 ivanmejia. All rights reserved.
//

import Foundation
import Alamofire

class VividSeatsService: IVividSeatsService {
    let serviceEndpoint: String = "https://webservices.vividseats.com"

    func loadCards(cards:@escaping Cards) {

        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        let todaysDate = dateFormatter.string(from: date)
        let date2 = date.addingTimeInterval(60*60*24*5)
        let futureDate = dateFormatter.string(from: date2)

        Alamofire.request("\(serviceEndpoint)/rest/mobile/v1/home/cards",
            method: .post,
            parameters: ["startDate":todaysDate,"endDate": futureDate,"includeSuggested": "true"],
            encoding: JSONEncoding.default,
            headers: ["X-Mobile-Platform":"iOS|Android", "Content-Type":"application/json"])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    if let jsonStr = String(data: response.data!, encoding: .utf8) {
                        let decoder = JSONDecoder()
                        let jsonData = try decoder.decode([Card].self, from: jsonStr.data(using: .utf8)!)
                        cards(jsonData, nil)
                    }
                }
                catch let error {
                    print("error decoding JSON: \(error)")
                    cards(nil, VividSeatsServiceException.invalidDataFormat)
                }
        }
    }

    func loadCardImage(url: String, cardImage: @escaping CardImage) {
        Alamofire.request(url).responseData { (rawData) in

            if let image = UIImage(data: rawData.data!) {
                cardImage(image)
            }
            else {
                cardImage(nil)
            }

        }
    }
}
