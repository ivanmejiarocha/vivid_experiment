//
//  IVividSeatsService.swift
//  VividApp
//
//  Created by Ivan Mejia on 9/3/18.
//  Copyright © 2018 ivanmejia. All rights reserved.
//

import Foundation
import UIKit

typealias Cards = ([Card]?, Error?) -> Void
typealias CardImage = (UIImage?) -> Void

enum VividSeatsServiceException: Error {
    case remoteServiceUnavailable
    case invalidDataFormat
}

protocol IVividSeatsService {
    func loadCards(cards:@escaping Cards)
    func loadCardImage(url: String, cardImage: @escaping CardImage)
}
