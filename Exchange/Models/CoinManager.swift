//
//  CoinManager.swift
//  Exchange
//
//  Created by Mac OS on 11.04.2023.
//

import Foundation

protocol CurrencyManagerDelegate {
    func didUpdateCurrency(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://www.worldcoinindex.com/apiservice/ticker?key="
    let apiKey = "Vy170PPbEos0QxFa1vNYt27z9O2LfO9ldlC"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CurrencyManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)\(apiKey)&label=btcbtc&fiat=\(currency)"
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    print(error!)
                    return
                }
            
                if let safeData = data {
                    if let price = self.parseJSON(safeData) {
                        let priceString = String(format: "%.2f", price)
                        self.delegate?.didUpdateCurrency(price: priceString, currency: currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ currencyData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: currencyData)
            let rate = decodedData.Markets[0].Price
            let rate1 = decodedData.Markets.count
            return rate
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
