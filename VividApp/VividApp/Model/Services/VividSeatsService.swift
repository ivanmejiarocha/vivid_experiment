//
//  VividSeatsService.swift
//  VividApp
//
//  Created by Ivan Mejia on 9/3/18.
//  Copyright © 2018 ivanmejia. All rights reserved.
//

import Foundation
import Alamofire

typealias Cards = ([Card]) -> Void
typealias CardImage = (UIImage?) -> Void

class VividSeatsService {
    let serviceEndpoint: String = "https://webservices.vividseats.com"

    func loadCards(cards:@escaping Cards) {
        Alamofire.request("\(serviceEndpoint)/rest/mobile/v1/home/cards",
            method: .post,
            parameters: ["startDate": "2018-09-02","endDate": "2018-09-18","includeSuggested": "true"],
            encoding: JSONEncoding.default,
            headers: ["X-Mobile-Platform":"iOS|Android", "Content-Type":"application/json"])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                do {
                    if let jsonStr = String(data: response.data!, encoding: .utf8) {
                        let decoder = JSONDecoder()
                        let jsonData = try decoder.decode([Card].self, from: jsonStr.data(using: .utf8)!)
                        cards(jsonData)
                    }
                }
                catch let error {
                    print("error decoding JSON: \(error)")
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
