//
//  CoinModel.swift
//  Exchange
//
//  Created by Mac OS on 11.04.2023.
//

import Foundation

struct CoinModel {
    let rate: Double
    
    var rateString: String {
        return String(format: "%.1f", rate)
    }
}
