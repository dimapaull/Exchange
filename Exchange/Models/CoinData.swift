//
//  CoinData.swift
//  Exchange
//
//  Created by Mac OS on 11.04.2023.
//

import Foundation

struct CoinData: Decodable {
    let Markets: [Markets]
}

struct Markets: Decodable {
    let Price: Double
}
