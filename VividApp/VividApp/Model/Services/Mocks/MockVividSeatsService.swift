//
//  MockVividSeatsService.swift
//  VividApp
//
//  Created by Ivan Mejia on 9/3/18.
//  Copyright © 2018 ivanmejia. All rights reserved.
//

import Foundation

class MockVividSeatsService: IVividSeatsService {

    func loadCards(cards:@escaping Cards) {
        cards(nil, VividSeatsServiceException.invalidDataFormat)
    }

    func loadCardImage(url: String, cardImage: @escaping CardImage) {
        cardImage(nil)
    }
}
