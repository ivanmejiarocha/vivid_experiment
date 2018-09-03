//
//  HomeViewModel.swift
//  VividApp
//
//  Created by Ivan Mejia on 9/3/18.
//  Copyright © 2018 ivanmejia. All rights reserved.
//

import Foundation

class HomeViewModel {
    private var cards: [Card]?

    func loadCards(cards: @escaping Cards) {
        if let c = self.cards {
            cards(c)
        }
        else {
            let service = VividSeatsService()
            service.loadCards(cards: cards)
        }
    }
}
