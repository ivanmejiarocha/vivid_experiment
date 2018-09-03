//
//  VividCard.swift
//  VividApp
//
//  Created by Ivan Mejia on 9/3/18.
//  Copyright © 2018 ivanmejia. All rights reserved.
//

import Foundation

struct Card: Codable {

    var topLabel: String
    var middleLabel: String
    var bottomLabel: String
    var eventCount: Int
    var image: String
    var targetId: Int32
    var targetType: String
    var entityId: Int
    var entityType: String
    var startDate: Int64
    var rank: Int
}
